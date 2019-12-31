#' @title Get Spotify Item
#' @name get_spotify_item
#' @description This function searches spotify item by name
#' @author Alberto Almuiña
#' @param name String of item name (artist, album, track...). Default: NULL
#' @param type String of the search type. Possible values are 'artist', 'album' and 'track'.
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 1, max of 50.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @param artist String of album's artist name. Default: NULL
#' @param album String of album name. Default: NULL
#' @details You have two options to use this function: Search by parameter name or search by parameters artist + album. In this second case, type must always be 'album'.
#' @return
#' Returns a data frame with the item's information
#' @export
#' @examples
#' \dontrun{
#' get_spotify_item(name = 'Arctic Monkeys', type = 'artist')
#' get_spotify_item(artist = 'Leiva', album = 'Nuclear', type = 'album')
#' get_spotify_item(name = 'Do I Wanna Know?', type = 'track')
#' }


get_spotify_item<- function(name = NULL, type, limit = 1, offset = 0, access_token = DSpoty::get_spotify_access_token(),
                            artist = NULL, album = NULL){

  if(is.null(name) & is.null(artist) & is.null(album)){stop(str_glue('Parameters name, artist and album are NULL.
                                                                     You have to enter name or artist+album'))}

  if(!is.null(name) & (!is.null(artist) | !is.null(album))){stop(str_glue('Parameters name, artist and album are NOT NULL.
                                                                     You have to enter name or artist+album'))}

  type<-match.arg(type, choices = c('album','track','artist'))

  if(!is.null(name) & is.null(artist) & is.null(album)){

    params<-list(q=str_replace_all(name, pattern = ' ', replacement = '+'),
                 type = type,
                 offset = offset,
                 limit = limit,
                 access_token= access_token
    )

  }

  if(is.null(name) & !is.null(artist) & !is.null(album)){

    params <- list(q=str_glue('artist:{artist} album:{album}'),
                   type = type,
                   offset = offset,
                   limit = limit,
                   access_token= access_token
    )

  }

  res<-RETRY('GET', url = 'https://api.spotify.com/v1/search',
             query = params,
             quiet = TRUE) %>%
    content %>%
    .[[switch(type,
              artist = 'artists',
              album = 'albums',
              track = 'tracks')]] %>%
    .$items

  item<-map_df(seq_len(length(res)), function(this_row){

    info<-res[[this_row]]

    switch(type,

           artist = list(

             artist_name = info$name,
             artist_uri = info$id,
             artist_img = if(length(info$images)>0){info$images[[1]]$url} else {NA},
             num_followers = if(length(info$followers[[2]])>0) {as.character(info$followers[[2]])} else{NA},
             spotify_url = info$href,
             popularity = as.character(info$popularity),
             musical_genre = if(length(info$genres)>0){str_replace_all(str_c(unlist(info$genres), collapse = "-")," ","_")} else {NA}
           ),

           album = list(

             album_uri = info$id,
             album_name = info$name,
             album_type = if_else(length(info$album_type)>0,info$album_type, NULL),
             album_img = if_else(length(info$images)>0, info$images[[1]]$url, NULL),
             album_url = info$external_urls[[1]],
             release_date = info$release_date,
             release_date_precision = info$release_date_precision,
             total_tracks = info$total_tracks,
             available_markets = info$available_markets[[1]],
             popularity = get_album_popularity(info$id)
           ),

           track = list(

             track_name = info$name,
             track_uri = info$id,
             artist_name = info$artists[[1]]$name,
             artist_uri = info$artists[[1]]$id,
             disc_number = info$disc_number,
             track_duration_ms = info$duration_ms,
             explicit = paste(info$explicit),
             spotify_url = info$external_urls$spotify,
             track_mp3_30s = if_else(is.null(info$preview_url), "NULL", info$preview_url),
             track_number = info$track_number
           )
    )

  })

  item<-switch(type,
               artist = item %>% filter(., !duplicated(tolower(artist_name))) %>% filter(., !duplicated(tolower(artist_uri))),
               album = item,
               track = item)

  return(item)

}

#' @title Get Several Artists
#' @name get_several_artists
#' @description This function allows you to load several artists in a faster way.
#' @author Alberto Almui?a
#' @param artist_ids_df Dataframe containing the artists ids in one of the columns.
#' @param ids_label Integer indicating the column number of the artists ids. Default to 1.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @return
#' Returns a data frame with all the artist's information
#' @export
#' @examples
#' \dontrun{
#' get_several_artists(df,1)
#' }

get_several_artists<-function(artist_ids_df, ids_label = 1, access_token = DSpoty::get_spotify_access_token()){


  uris<-artist_ids_df[,ids_label] %>% split(., ceiling(seq_along(.)/50)) %>% .$`1` %>% apply(., paste, MARGIN=2, collapse = ',')

  res<-lmap(seq_len(length(uris)), function(x){

    res1<-RETRY('GET',
                url = str_glue('https://api.spotify.com/v1/artists/'),
                query = list(ids=uris[[x]], type = 'artist', access_token= access_token),
                quiet = TRUE) %>%
      content %>%
      .$artists
  })

  artista<-map_df(seq_len(length(res)), function(this_row){

    artist<-res[[this_row]]

    list(
      artist_name = artist$name,
      artist_uri = artist$id,
      artist_img = if(length(artist$images)>0){artist$images[[1]]$url} else {NA},
      num_followers = if(length(artist$followers[[2]])>0) {as.character(artist$followers[[2]])} else{NA},
      spotify_url = artist$external_urls$spotify,
      popularity = as.character(artist$popularity),
      musical_genre = if(length(artist$genres)>0){str_replace_all(str_c(unlist(artist$genres), collapse = "-")," ","_")} else {NA}

    )
  }) %>%
    filter(.,!duplicated(tolower(artist_uri))) %>%
    filter(.,!duplicated(tolower(artist_name)))

  return(artista)

}

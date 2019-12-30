#' @title Get Artist
#' @name get_artist
#' @description This function searches spotify artists by name
#' @author Alberto Almui?a
#' @param artist_name String of artist name
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 1, max of 50.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @return
#' Returns a data frame with the artist's information
#' @export
#' @examples
#' \dontrun{
#' get_artist('Arctic Monkeys')
#' }

get_artist<-function(artist_name, offset='0', limit='1', access_token = DSpoty::get_spotify_access_token()){

  if(is.character(artist_name)==F){

    stop(str_glue('The parameter artist_name has to be a string. The value introduced is "{artist_name}'))
  }

  res<-RETRY('GET', url = 'https://api.spotify.com/v1/search',
              query = list(q=artist_name,
                       type = 'artist',
                       offset = offset,
                       limit = limit,
                       access_token= access_token),
              quiet = TRUE) %>%
                  content %>%
                  .$artist %>%
                  .$items


  artista<-map_df(seq_len(length(res)), function(this_row){

                artist<-res[[this_row]]

                list(
                  artist_name = artist$name,
                  artist_uri = artist$id,
                  artist_img = if(length(artist$images)>0){artist$images[[1]]$url} else {NA},
                  num_followers = if(length(artist$followers[[2]])>0) {as.character(artist$followers[[2]])} else{NA},
                  spotify_url = artist$href,
                  popularity = as.character(artist$popularity),
                  musical_genre = if(length(artist$genres)>0){str_replace_all(str_c(unlist(artist$genres), collapse = "-")," ","_")} else {NA}

                )

              }) %>%
                filter(.,!duplicated(tolower(artist_name))) %>%
                filter(.,!duplicated(tolower(artist_uri)))


  return(artista)

}

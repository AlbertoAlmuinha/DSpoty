#' @title Get Album Popularity
#' @name get_album_popularity
#' @description This function returns the popularity of an album on Spotify.
#' @author Alberto Almui?a
#' @param album_uri An album uri from Spotify to search for or a group of albums uris separated by a comma
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 1, max of 50.
#' @return
#' Returns an integer vector with the popularity value (0-100).
#' @export
#' @examples
#' \dontrun{
#' get_album_popularity('1T2uKSyUf7DBWOABtsmYLM')
#' }

get_album_popularity <- function(album_uri, limit = 1, offset = 0, access_token = DSpoty::get_spotify_access_token()){

  if(nchar(album_uri)!= 22 || is.character(album_uri) == F) {stop('The parameter album_uri has to be valid')}

  res<-RETRY('GET',
          str_glue('https://api.spotify.com/v1/albums/?ids={album_uri}'),
          query = list(limit = limit,
                       offset = offset,
                       access_token = access_token
          ),
          quiet = TRUE,
          times = 10) %>% content %>% .$albums %>% .[[1]] %>% .$popularity

  return(res)
}

#' @title Get Track Popularity
#' @name get_track_popularity
#' @description This function that returns the popularity of a track uri on Spotify.
#' @author Alberto Almui?a
#' @param track_uri A track uri corresponding to one track in Spotify.
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 1, max of 50.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token().
#' @return
#' Returns an integer vector with the popularity value (0-100).
#' @export
#' @examples
#' \dontrun{
#' popularity <- get_track_popularity('0FgNSsaSZTvbLXUumSO8LQ')
#' }



get_track_popularity <- function(track_uri, limit = 1, offset = 0, access_token = DSpoty::get_spotify_access_token()){

  if(nchar(track_uri)!= 22 || is.character(track_uri) == F){stop('track_uri parameter is not correct')}


    res<-RETRY('GET',
                str_glue('https://api.spotify.com/v1/tracks/?ids={track_uri}'),
                query = list(limit = limit,
                             offset = offset,
                             access_token = access_token
                ),
                quiet = TRUE,
                times = 10) %>% content %>% .$tracks %>% .[[1]] %>% .$popularity


  return(res)

}

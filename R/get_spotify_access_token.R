#' @title Get Spotify Access Token.
#' @name get_spotify_access_token
#' @description This function returns the Spotify's access token.
#' @author Alberto Almui?a
#' @param client_id String with the Spotify CLIENT_ID.
#' @param client_secret String with the Spotify CLIENT_SECRET.
#' @return
#' Returns a string with de access token.
#' @export
#' @examples
#' \dontrun{
#' access_token<-get_spotify_access_token(client_id = 'client_id', client_secret = 'client_secret')
#' }

get_spotify_access_token<-function(client_id = Sys.getenv('client_id'), client_secret = Sys.getenv('client_secret')){

  access_token<-RETRY('POST',
                      'https://accounts.spotify.com/api/token',
                      authenticate(client_id, client_secret),
                      body = list(grant_type = 'client_credentials'),
                      encode = 'form') %>%
    content %>% .$access_token

  return(access_token)

}

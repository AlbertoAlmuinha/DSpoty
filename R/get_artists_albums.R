#' @title Get Artist Albums
#' @name get_artist_albums
#' @description This function returns an artist's discography on Spotify.
#' @author Alberto Almuiña
#' @param artist_name String of artist name.
#' @param album_type Character vector of album types to include. Valid values are "album", "single", "appears_on", and "compilation". Defaults to "album".
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 50, max of 50.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @return
#' Returns a data frame with all the albums of the selected artist
#' @export
#' @examples
#' \dontrun{
#' albums <- get_artist_albums('radiohead')
#' }

get_artist_albums<-function(artist_name, album_type = 'album',limit=50, offset=0,
                     access_token = DSpoty::get_spotify_access_token()){

  if(is.character(artist_name)==F){

    stop(str_glue('The parameter artist_name has to be a string. The value introduced is "{artist_name}'))
  }

  album_type<-match.arg(album_type, choices = c('album', 'single', 'appears_on', 'compilation'))

  artist_uri<-DSpoty::get_artist(artist_name = artist_name, limit = 1) %>% .$artist_uri


  res<-RETRY('GET',
              url = str_glue('https://api.spotify.com/v1/artists/{artist_uri}/albums'),
              query = list(limit = limit,
                           offset = offset,
                           include_groups = paste(album_type, collapse = ","),
                           access_token = access_token),
              quiet = TRUE,
              times = 10) %>% content %>% .$items

  album<-map_df(seq_len(length(res)), function(this_row){

              album_info<-res[[this_row]]

              list(
                album_uri = album_info$id,
                album_name = album_info$name,
                rel_album_artista = if_else(length(album_info$album_group)>0,album_info$album_group, NULL),
                album_type = if_else(length(album_info$album_type)>0,album_info$album_type, NULL),
                album_img = if_else(length(album_info$images)>0, album_info$images[[1]]$url, NULL),
                album_url = album_info$external_urls[[1]],
                release_date = album_info$release_date,
                release_date_precision = album_info$release_date_precision,
                total_tracks = album_info$total_tracks,
                available_markets = album_info$available_markets[[1]],
                popularity = get_album_popularity(album_info$id)

              )
            }) %>% filter(!duplicated(tolower(album_uri))) %>%
                    filter(!duplicated(tolower(album_name)))


  return(album)

}

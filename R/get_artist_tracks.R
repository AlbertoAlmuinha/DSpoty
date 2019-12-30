#' @title Get Artist Tracks
#' @name get_artist_tracks
#' @description This function returns all the tracks of an artist.
#' @author Alberto Almui?a
#' @param artist_name String of artist name.
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 50, max of 50.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token().
#' @return
#' Returns a data frame with all the tracks of the selected artist.
#' @export
#' @examples
#' \dontrun{
#' tracks <- get_artist_tracks('Shakira')
#' }

get_artist_tracks<-function(artist_name, limit = 50, offset = 0, access_token = DSpoty::get_spotify_access_token()){

  if(is.character(artist_name)==F){

    stop(str_glue('The parameter artist_name has to be a string. The value introduced is "{artist_name}'))
  }

  album_uris<-DSpoty::get_artists_albums(artist_name) %>% .$album_uri

  tracks<-map_df(seq_len(length(album_uris)), function(this_album){

    res<-RETRY('GET',
            str_glue('https://api.spotify.com/v1/albums/{album_uris[this_album]}/tracks'),
            query = list(limit=limit,
                         offset = offset,
                         access_token = access_token),
            quiet = TRUE,
            times = 10) %>% content %>% .$items


      map_df(seq_len(length(res)), function(this_truck){

            track_info<-res[[this_truck]]

            list(
              nombre_cancion = track_info$name,
              cancion_uri = track_info$id,
              album_uri = album_uris[this_album],
              artista_uri = track_info$artists[[1]]$id,
              numero_disco = track_info$disc_number,
              duracion_cancion_ms = track_info$duration_ms,
              letra_explicita = paste(track_info$explicit),
              spotify_url = track_info$external_urls$spotify,
              cancion_mp3_60s = if_else(is.null(track_info$preview_url), "NULL", track_info$preview_url),
              numero_cancion_disco = track_info$track_number

            )
      })

  })

  return(tracks)

}

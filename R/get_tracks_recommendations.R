#' @title Get Tracks Recommendations
#' @name get_tracks_recommendations
#' @description This function returns the recommendend songs by Spotify.
#' @author Alberto Almui?a
#' @param artist_uri Artist ID.
#' @param track_uri Track ID.
#' @param limit Integer indicating the max number of artists to return. Default 10.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token().
#' @return
#' Returns a data frame with the recommended artists information.
#' @export
#' @examples
#' \dontrun{
#' get_tracks_recommendations('7Ln80lUS6He07XvHI8qqHH', '0FgNSsaSZTvbLXUumSO8LQ')
#' }

get_tracks_recommendations<-function(artist_uri, track_uri, limit = 10, access_token = DSpoty::get_spotify_access_token()){

  res<-RETRY('GET', url = 'https://api.spotify.com/v1/recommendations',
             query = list(seed_artists=artist_uri,
                          seed_tracks = track_uri,
                          limit = limit,
                          access_token= access_token),
             quiet = TRUE) %>% content %>% .$tracks

  recommendations<-map_df(seq_len(length(res)), function(this_list){

    info<-res[[this_list]]

    list(
      nombre_cancion = info$name,
      popularidad_cancion = info$popularity,
      nombre_artista = info$artists[[1]]$name,
      duracion_cancion_ms = info$duration_ms,
      cancion_mp3_60s = if_else(is.null(info$preview_url), "NULL", info$preview_url),
      url_cancion = info$external_urls$spotify,
      url_artista = info$artists[[1]]$external_urls$spotify,
      artista_uri = info$artists[[1]]$id,
      cancion_uri = info$id
    )

  }) %>% arrange(desc(popularidad_cancion))

  return(recommendations)

}

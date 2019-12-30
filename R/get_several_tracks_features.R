#' @title Get Several Tracks Features
#' @name get_several_tracks_features
#' @description This function allows you to load several tracks features in a faster way.
#' @author Alberto Almui?a
#' @param tracks_df Dataframe containing the tracks ids in the first column.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token().
#' @return
#' Returns a data frame with all the tracks_features for the selected tracks uris.
#' @export
#' @examples
#' \dontrun{
#' get_several_tracks_features(df)
#' }

get_several_tracks_features<-function(tracks_df, access_token = DSpoty::get_spotify_access_token()){

  tracks_uris<-tracks_df[,1] %>% split(., ceiling(seq_along(.)/100)) %>% .[[1]] %>% lapply(., paste, collapse = ',')

  res<-lmap(seq_len(length(tracks_uris)), function(x){

    res1<-RETRY('GET',
                str_glue('https://api.spotify.com/v1/audio-features'),
                query = list(ids = tracks_uris[[x]],
                             access_token = access_token),
                quiet = TRUE,
                times = 10) %>% content %>% .$audio_features
  })

  tracks_features<- map_df(seq_len(length(res)), function(this_truck){

    track_info<-res[[this_truck]]

    list(
      cancion_uri = track_info$id,
      bailabilidad = track_info$danceability,
      energia = track_info$energy,
      tono = track_info$key,
      volumen = track_info$loudness,
      modo = track_info$mode,
      discursos = track_info$speechiness,
      acustica = track_info$acousticness,
      instrumentalidad = track_info$instrumentalness,
      vitalidad = track_info$liveness,
      valencia = track_info$valence,
      tempo = track_info$tempo,
      compas = track_info$time_signature,
      popularidad = get_track_popularity(track_info$id)

    )
  })

  return(tracks_features)


}

#' @title Get Several Tracks Features Vectorized
#' @name get_several_tracks_features_vectorized
#' @description This function allows you to load several tracks features really fast specially with a large amount of tracks. Improves the performance in comparision with get_several_tracks_features.
#' @author Alberto Almui?a
#' @param tracks_df Dataframe containing the tracks ids in the first column.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token().
#' @return
#' Returns a data frame with all the tracks_features for the selected tracks uris.
#' @export
#' @examples
#' \dontrun{
#' get_several_tracks_features_vectorized(df)
#' }

get_several_tracks_features_vectorized<-function(tracks_df, access_token = DSpoty::get_spotify_access_token()){

  tracks_uris<-tracks_df[,1] %>% split(., ceiling(seq_along(.)/100)) %>% .$`1` %>% apply(., paste, MARGIN=2, collapse = ',')

  res<-lmap(seq_len(length(tracks_uris)), function(x){

    res1<-RETRY('GET',
                str_glue('https://api.spotify.com/v1/audio-features'),
                query = list(ids = tracks_uris[[x]],
                             access_token = access_token),
                quiet = TRUE,
                times = 10) %>% content %>% .$audio_features
  })

  na_index<-sapply(res, is_list) %>% unlist() %>% as_vector() %>% which(.==T)

  res<-res[na_index] %>% unlist(recursive = F, use.names = F)

  loc<-which(sapply(res, is.null))

  res[loc]<-NA

  res<-res %>% unlist()

  indices<-lapply(c(13, seq(1,11,1), 18), function(x) seq(x,length(unlist(res, recursive = F, use.names = F)), 18))

  tracks_features<-matrix(nrow = length(indices[[1]]), ncol = 13) %>% as.data.frame() %>% set_names(., nm = "track_uri", "danceability", "energy", "key", "loudness", "mode",
                                                                                                    "speechiness", "acousticness", "instrumentalness", "liveness", "valence", "tempo",
                                                                                                    "time_signature")

  for(i in 1:length(indices)){

    tracks_features[,i]<- res[indices[[i]]]
  }

  return(tracks_features)

}

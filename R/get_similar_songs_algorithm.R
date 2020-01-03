#' @title Get Similar Songs Algorithm
#' @name get_similar_songs_algorithm
#' @description This function finds the most similar songs based on related artists.
#' @author Alberto Almuiña
#' @param artist_name String of artist name
#' @param artist_track String of artst track
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @return
#' Returns a data frame with the tracks information
#' @export
#' @examples
#' \dontrun{
#' get_similar_songs_algorithm('Leiva', 'Nuclear')
#' }


get_similar_songs_algorithm<-function(artist_name, artist_track,
                                      access_token = DSpoty::get_spotify_access_token()){

  artist_uri<-DSpoty::get_artist(artist_name = artist_name) %>% .$artist_uri

  rel_artists<-DSpoty::get_related_artists(artist_uri = artist_uri)

  tracks_rel<-map_df(seq(length(rel_artists)), function(this_artist){

    DSpoty::get_artist_tracks(rel_artists$artist_name[this_artist])

  })

  tracks_features_rel<-map_df(seq(length(rel_artists)), function(this_artist){

    DSpoty::get_artist_tracks_features(rel_artists$artist_name[this_artist])

  })

  tracks_features_rel<-inner_join(tracks_features_rel, tracks_rel, by='track_uri') %>% select(1:15)

  tracks_features_rel<- tracks_features_rel %>% filter(., !duplicated(tolower(track_name)))

  features<-DSpoty::get_artist_tracks_features(artist_name = artist_name)

  track<-DSpoty::get_artist_tracks(artist_name = artist_name) %>% .[.$track_name == artist_track,] %>% .$track_uri

  suppressWarnings({

    df<-union_all(features[features$track_uri==track,2:14],
                  tracks_features_rel[,2:14], by = 'track_uri')

    d<-dist(df) %>% as.matrix() %>% as.data.frame() %>%
      apply(., 2, order, decreasing = TRUE) %>% as.data.frame() %>% .[1:10,1]

    top_similar_songs<-inner_join(tracks_rel[d,], rel_artists, by = 'artist_uri') %>%
      select('artist_name', 'track_name', 'spotify_url', 'track_mp3_30s', 'url_img')

  })

  return(top_similar_songs)

}

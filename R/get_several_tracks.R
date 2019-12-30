#' @title Get Several Tracks
#' @name get_several_tracks
#' @description This function allows you to load several tracks in a faster way.
#' @author Alberto Almui?a
#' @param tracks_id_df Dataframe containing the tracks ids in one of the columns.
#' @param ids_label Integer indicating the column number of the tracks ids. Default to 1.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @return
#' Returns a data frame with all the artist's information
#' @export
#' @examples
#' \dontrun{
#' get_several_tracks(df,1)
#' }


get_several_tracks<-function(tracks_id_df, ids_label = 1, access_token = DSpoty::get_spotify_access_token()){


  uris<-tracks_id_df[,ids_label] %>% split(., ceiling(seq_along(.)/50)) %>% .$`1` %>% apply(., paste, MARGIN=2, collapse = ',')

  res<-lmap(seq_len(length(uris)), function(x){

    res1<-RETRY('GET',
                url = str_glue('https://api.spotify.com/v1/tracks/'),
                query = list(ids=uris[[x]], access_token= access_token),
                quiet = TRUE) %>%
      content %>%
      .$tracks
  })

  tracks<-map_df(seq_len(length(res)), function(this_row){

    track<-res[[this_row]]

    list(
      track_name = track$name,
      track_uri = track$id,
      track_url = track$external_url$spotify,
      artist_uri = track$artists[[1]]$id,
      artist_name = track$artists[[1]]$name,
      track_mp3_30s = if_else(is.null(track$preview_url), "NULL", track$preview_url)

    )
  })

  return(tracks)

}

#' @title Get Related Artists
#' @name get_related_artists
#' @description This function returns the most similar artists of the selected artist.
#' @author Alberto Almui?a
#' @param artist_uri Artist ID.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @return
#' Returns a data frame with the related artist information.
#' @export
#' @examples
#' \dontrun{
#' get_related_artists('7Ln80lUS6He07XvHI8qqHH')
#' }

get_related_artists<-function(artist_uri, access_token = DSpoty::get_spotify_access_token()){

  if(is.character(artist_uri)==F){

    stop(str_glue('The parameter artist_name has to be a string. The value introduced is "{artist_name}'))
  }

  res<-RETRY('GET', url = str_glue('https://api.spotify.com/v1/artists/{artist_uri}/related-artists'),
             query = list(access_token= access_token),
             quiet = TRUE) %>%
    content %>% .$artists


  rel_artists<-map_df(seq_len(length(res)), function(this_row){

    rel_info<-res[[this_row]]

    list(
      artist_name = rel_info$name,
      artist_uri = rel_info$id,
      popularity = rel_info$popularity,
      url_img = if_else(length(rel_info$images)>0, rel_info$images[[1]]$url, NULL)

    )
  })

  return(rel_artists)

}

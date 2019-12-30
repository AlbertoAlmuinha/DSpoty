#' @title Get Artists by Genre
#' @name get_artists_by_genre
#' @description Function to search artists by genre
#' @author Alberto Almui?a
#' @param genre String of genre name to search for
#' @param offset Integer indicating the offset of the first artist to return. Defaults to 0 (Spotify's API default value).
#' @param limit Integer indicating the max number of artists to return. Defaults to 10, max of 50.
#' @param access_token Spotify Web API token. Defaults to DSpoty::get_spotify_access_token()
#' @param year Year to search for
#' @return
#' Returns a data frame with the artist's information of a determined genre
#' @export
#' @examples
#' \dontrun{
#' rock_artists <- get_artists_by_genre("rock")
#' }


get_artists_by_genre<-function(genre=is.character(), offset='0', limit='10',year = 2019,
                               access_token = DSpoty::get_spotify_access_token()){

  if(is.character(genre)==F){

    stop(str_glue('The parameter genre has to be a string. The value introduced is: {genre}'))
  }

  res<-RETRY('GET', url = 'https://api.spotify.com/v1/search',
            query = list(q=str_glue('genre:"{genre}"'),
                         type = 'artist',
                         year = year,
                         offset = offset,
                         limit = limit,
                         access_token= access_token),
            quiet = TRUE) %>%
              content %>%
              .$artist %>%
              .$items



  artista<-map_df(seq_len(length(res)), function(this_row){

                  artist<-res[[this_row]]

                  list(
                    nombre_artista = artist$name,
                    artista_uri = artist$id,
                    artista_img = if_else(length(artist$images)>0,artist$images[[1]]$url, NULL),
                    num_followers = if_else(length(artist$followers[[2]])>0, as.character(artist$followers[[2]]),NULL),
                    spotify_url = artist$href,
                    popularidad = as.character(artist$popularity),
                    estilo_musical = if_else(length(artist$genres)>0,
                                             str_replace_all(str_c(unlist(artist$genres), collapse = "-")," ","_"),
                                             NULL)

                  )

                }) %>%
                  filter(.,!duplicated(tolower(artista_uri))) %>%
                  filter(.,!duplicated(tolower(nombre_artista)))

  return(artista)

}

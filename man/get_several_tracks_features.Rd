% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_several_tracks_features.R
\name{get_several_tracks_features}
\alias{get_several_tracks_features}
\title{Get Several Tracks Features}
\usage{
get_several_tracks_features(tracks_df,
  access_token = DSpoty::get_spotify_access_token())
}
\arguments{
\item{tracks_df}{Dataframe containing the tracks ids in the first column.}

\item{access_token}{Spotify Web API token. Defaults to DSpoty::get_spotify_access_token().}
}
\value{
Returns a data frame with all the tracks_features for the selected tracks uris.
}
\description{
This function allows you to load several tracks features in a faster way.
}
\examples{
\dontrun{
get_several_tracks_features(df)
}
}
\author{
Alberto Almui?a
}

# DSpoty

R Package to Get Multiple Information from Spotify API.

# Installation

`devtools::install_github('https://github.com/AlbertoAlmuinha/DSpoty')`

# Authentication

You need to get your Spotify API Client ID and Secret ID. You can get yours [here](https://developer.spotify.com/dashboard/) .
The best way to authenticate is to set your ID's to system environment variables (client_id and secret_id). If you prefer, you can use your ID's en each function to call the function get_spotify_access_token, but it's not recomendable.

```
Sys.setenv(client_id = 'client_id')
Sys.setenv(client_secret = 'client_secret')

access_token <- DSpoty::get_spotify_access_token()
```

# Get Artist Information

You can get an artist Spotify information with the function get_artists. This function returns data like the name of the artist, links to open in spotify, popularity, number of followers or musical genre.

```
artist <- get_artists('Arctic Monkeys')
```

Another option is to search artists by musical genre. You can choose the number of artists returned and the year. The information returned is the same that with get_artists function.

```
artists_by_genre <- get_artists_by_genre('rock', limit = 20, year = 2019)
```

Finally, you can search related artists. In this case, you need the artist ID (and not the name) to use the function. You can get this information from the function get_artists or artists_by_genre. You will get the top 20 related artist.

```
related_artists<-get_related_artists(artist_uri = artist$artista_uri)
```

# Get Albums Information

You can get the whole discography of an artist in few seconds with the function get_artists_albums. You must select one of the next options to the parameter album_type (default option is album):

- album
- single
- appears_on
- compilation

```
albums <- get_artists_albums('Arctic Monkeys')

albums <- get_artists_albums('Arctic Monkeys', album_type = 'appears_on', limit = 20)
```

# Get Tracks Information

Firstly, you can get all the tracks of an artist. This can be done with the next function:

```
tracks <- get_artist_tracks('Arctic Monkeys')
```

You can also get all the tracks features information (like danceability, mode, acousticness, speechness, valence, loudness...) for an artist:

```
features <- get_artist_tracks_features('Arctic Monkeys')
```

You can also search for tracks recommendations based on another track. You can choose the number of recommended tracks returned:

```
recommended_songs <- get_tracks_recommendations_by_name('Arctic Monkeys', 'Do I Wanna Know?', limit = 10)
```













# DSpoty

R Package to Get Multiple Information from Spotify API.

# Installation

`devtools::install_github('https://github.com/AlbertoAlmuinha/DSpoty')`

# Authentication

You need to get your Spotify API Client ID and Secret ID. You can get yours [here] (https://developer.spotify.com/dashboard/).
The best way to authenticate is to set your ID's to system environment variables (client_id and secret_id). If you prefer, you can use your ID's en each function to call the function get_spotify_access_token, but it's not recomendable.

``
Sys.setenv(client_id = 'client_id')
Sys.setenv(client_secret = 'client_secret')

access_token <- DSpoty::get_spotify_access_token()
``





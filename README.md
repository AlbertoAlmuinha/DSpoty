
# DSpoty

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

R Package to Get Multiple Information from Spotify API.

# Installation

``` r
devtools::install_github('https://github.com/AlbertoAlmuinha/DSpoty')
```

# Authentication

You need to get your Spotify API Client ID and Secret ID. You can get
yours [here](https://developer.spotify.com/dashboard/) . The best way to
authenticate is to set your ID’s to system environment variables
(client\_id and secret\_id). If you prefer, you can use your ID’s en
each function to call the function get\_spotify\_access\_token, but it’s
not recomendable.

``` r
Sys.setenv(client_id = 'client_id')
Sys.setenv(client_secret = 'client_secret')

access_token <- DSpoty::get_spotify_access_token()
```

# Get Artist Information

You can get an artist Spotify information with the function
get\_artists. This function returns data like the name of the artist,
links to open in spotify, popularity, number of followers or musical
genre.

``` r
artist <- get_artist('Arctic Monkeys')
```

<table>

<thead>

<tr>

<th style="text-align:left;">

artist\_name

</th>

<th style="text-align:left;">

artist\_uri

</th>

<th style="text-align:left;">

artist\_img

</th>

<th style="text-align:left;">

num\_followers

</th>

<th style="text-align:left;">

spotify\_url

</th>

<th style="text-align:left;">

popularity

</th>

<th style="text-align:left;">

musical\_genre

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Arctic Monkeys

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/ed0552e9746ed2bbf04ae4bcb5525700ca31522d>

</td>

<td style="text-align:left;">

8780891

</td>

<td style="text-align:left;">

<https://api.spotify.com/v1/artists/7Ln80lUS6He07XvHI8qqHH>

</td>

<td style="text-align:left;">

86

</td>

<td style="text-align:left;">

garage\_rock-modern\_rock-permanent\_wave-rock-sheffield\_indie

</td>

</tr>

</tbody>

</table>

Another option is to search artists by musical genre. You can choose the
number of artists returned and the year. The information returned is the
same that with get\_artists function.

``` r
artists_by_genre <- get_artists_by_genre('rock', limit = 20, year = 2019)
```

<table>

<thead>

<tr>

<th style="text-align:left;">

artist\_name

</th>

<th style="text-align:left;">

artist\_uri

</th>

<th style="text-align:left;">

artist\_img

</th>

<th style="text-align:left;">

num\_followers

</th>

<th style="text-align:left;">

spotify\_url

</th>

<th style="text-align:left;">

popularity

</th>

<th style="text-align:left;">

musical\_genre

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Queen

</td>

<td style="text-align:left;">

1dfeR4HaWDbWqFHLkxsg1d

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/b040846ceba13c3e9c125d68389491094e7f2982>

</td>

<td style="text-align:left;">

22469906

</td>

<td style="text-align:left;">

<https://api.spotify.com/v1/artists/1dfeR4HaWDbWqFHLkxsg1d>

</td>

<td style="text-align:left;">

93

</td>

<td style="text-align:left;">

glam\_rock-rock

</td>

</tr>

<tr>

<td style="text-align:left;">

The Beatles

</td>

<td style="text-align:left;">

3WrFJ7ztbogyGnTHbHJFl2

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/6b2a709752ef9c7aaf0d270344157f6cd2e0f1a7>

</td>

<td style="text-align:left;">

14688077

</td>

<td style="text-align:left;">

<https://api.spotify.com/v1/artists/3WrFJ7ztbogyGnTHbHJFl2>

</td>

<td style="text-align:left;">

91

</td>

<td style="text-align:left;">

british\_invasion-merseybeat-psychedelic\_rock-rock

</td>

</tr>

<tr>

<td style="text-align:left;">

Twenty One Pilots

</td>

<td style="text-align:left;">

3YQKmKGau1PzlVlkL1iodx

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/19e8f3bc875b7a4b9cf0041a5ee696c4be5478aa>

</td>

<td style="text-align:left;">

15682408

</td>

<td style="text-align:left;">

<https://api.spotify.com/v1/artists/3YQKmKGau1PzlVlkL1iodx>

</td>

<td style="text-align:left;">

88

</td>

<td style="text-align:left;">

modern\_rock-rock

</td>

</tr>

<tr>

<td style="text-align:left;">

Maroon 5

</td>

<td style="text-align:left;">

04gDigrS5kc9YWfZHwBETP

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/608c7b23420c9556a7eabd9097f7e171a91d3871>

</td>

<td style="text-align:left;">

21450933

</td>

<td style="text-align:left;">

<https://api.spotify.com/v1/artists/04gDigrS5kc9YWfZHwBETP>

</td>

<td style="text-align:left;">

94

</td>

<td style="text-align:left;">

pop-pop\_rock

</td>

</tr>

<tr>

<td style="text-align:left;">

Imagine Dragons

</td>

<td style="text-align:left;">

53XhwfbYqKCa1cC15pYq2q

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/01b36ca0f45f2f15117022a2754287a6ca1acdcc>

</td>

<td style="text-align:left;">

24260851

</td>

<td style="text-align:left;">

<https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q>

</td>

<td style="text-align:left;">

92

</td>

<td style="text-align:left;">

modern\_rock

</td>

</tr>

</tbody>

</table>

Finally, you can search related artists. In this case, you need the
artist ID (and not the name) to use the function. You can get this
information from the function get\_artists or artists\_by\_genre. You
will get the top 20 related artist.

``` r
related_artists<-get_related_artists(artist_uri = artist$artist_uri)
```

<table>

<thead>

<tr>

<th style="text-align:left;">

artist\_name

</th>

<th style="text-align:left;">

artist\_uri

</th>

<th style="text-align:right;">

popularity

</th>

<th style="text-align:left;">

url\_img

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

The Kooks

</td>

<td style="text-align:left;">

1GLtl8uqKmnyCWxHmw9tL4

</td>

<td style="text-align:right;">

73

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/0a3dfed5bce0e6d14703011ec52a42ae719c0d4b>

</td>

</tr>

<tr>

<td style="text-align:left;">

Alex Turner

</td>

<td style="text-align:left;">

1ctkBmvz80MGyi72Ix055S

</td>

<td style="text-align:right;">

66

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/ab67616d0000b273672951d44a35cb08092f2c1f>

</td>

</tr>

<tr>

<td style="text-align:left;">

The Last Shadow Puppets

</td>

<td style="text-align:left;">

2Z7UcsdweVlRbAk5wH5fsf

</td>

<td style="text-align:right;">

65

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/1e721c9502da1663fe9dd0b9f8a90519546f0a9f>

</td>

</tr>

<tr>

<td style="text-align:left;">

Blossoms

</td>

<td style="text-align:left;">

22RISwgVJyZu9lpqAcv1F5

</td>

<td style="text-align:right;">

66

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/b0722b13be43495b793d3911ef90403d62eb5d7b>

</td>

</tr>

<tr>

<td style="text-align:left;">

Kasabian

</td>

<td style="text-align:left;">

11wRdbnoYqRddKBrpHt4Ue

</td>

<td style="text-align:right;">

69

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/8ef02a528dfa5496a410aa80e8b0316574ca95b7>

</td>

</tr>

</tbody>

</table>

# Get Albums Information

You can get the whole discography of an artist in few seconds with the
function get\_artists\_albums. You must select one of the next options
to the parameter album\_type (default option is album):

  - album
  - single
  - appears\_on
  - compilation

<!-- end list -->

``` r
albums <- get_artist_albums('Arctic Monkeys')

albums <- get_artist_albums('Arctic Monkeys', album_type = 'appears_on', limit = 20)
```

<table>

<thead>

<tr>

<th style="text-align:left;">

album\_uri

</th>

<th style="text-align:left;">

album\_name

</th>

<th style="text-align:left;">

rel\_album\_artista

</th>

<th style="text-align:left;">

album\_type

</th>

<th style="text-align:left;">

album\_img

</th>

<th style="text-align:left;">

album\_url

</th>

<th style="text-align:left;">

release\_date

</th>

<th style="text-align:left;">

release\_date\_precision

</th>

<th style="text-align:right;">

total\_tracks

</th>

<th style="text-align:left;">

available\_markets

</th>

<th style="text-align:right;">

popularity

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

1nXwgYOolvutEaVWfGbP4w

</td>

<td style="text-align:left;">

Isles Of Wonder: Music For The Opening Ceremony Of The London 2012
Olympic Games

</td>

<td style="text-align:left;">

appears\_on

</td>

<td style="text-align:left;">

compilation

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/852299f998fe2b5c1e34450600c5bc8e4d432eef>

</td>

<td style="text-align:left;">

<https://open.spotify.com/album/1nXwgYOolvutEaVWfGbP4w>

</td>

<td style="text-align:left;">

2012-01-01

</td>

<td style="text-align:left;">

day

</td>

<td style="text-align:right;">

36

</td>

<td style="text-align:left;">

CA

</td>

<td style="text-align:right;">

14

</td>

</tr>

<tr>

<td style="text-align:left;">

1GvWtv7m3NX1vZ1Lk4i13M

</td>

<td style="text-align:left;">

The BRIT Awards 2012

</td>

<td style="text-align:left;">

appears\_on

</td>

<td style="text-align:left;">

compilation

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/209b4066a831af140c232d4bf6a3eadab013945d>

</td>

<td style="text-align:left;">

<https://open.spotify.com/album/1GvWtv7m3NX1vZ1Lk4i13M>

</td>

<td style="text-align:left;">

2012-01-01

</td>

<td style="text-align:left;">

day

</td>

<td style="text-align:right;">

61

</td>

<td style="text-align:left;">

GB

</td>

<td style="text-align:right;">

29

</td>

</tr>

<tr>

<td style="text-align:left;">

5GaeDKlnZggETclP0Y3FfE

</td>

<td style="text-align:left;">

Domino Sampler ’11

</td>

<td style="text-align:left;">

appears\_on

</td>

<td style="text-align:left;">

compilation

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/ab67616d0000b273d20f68791889d57d61a8400e>

</td>

<td style="text-align:left;">

<https://open.spotify.com/album/5GaeDKlnZggETclP0Y3FfE>

</td>

<td style="text-align:left;">

2011-12-20

</td>

<td style="text-align:left;">

day

</td>

<td style="text-align:right;">

18

</td>

<td style="text-align:left;">

CA

</td>

<td style="text-align:right;">

9

</td>

</tr>

<tr>

<td style="text-align:left;">

4jqIQ4srPIBcTcPdGFxdGF

</td>

<td style="text-align:left;">

All The Rage

</td>

<td style="text-align:left;">

appears\_on

</td>

<td style="text-align:left;">

compilation

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/ab67616d0000b2737c4f2e686a2fa77227fb5b53>

</td>

<td style="text-align:left;">

<https://open.spotify.com/album/4jqIQ4srPIBcTcPdGFxdGF>

</td>

<td style="text-align:left;">

2008-02-01

</td>

<td style="text-align:left;">

day

</td>

<td style="text-align:right;">

15

</td>

<td style="text-align:left;">

AD

</td>

<td style="text-align:right;">

29

</td>

</tr>

<tr>

<td style="text-align:left;">

3Vx8n3WCI0s0l2mvS0IMg3

</td>

<td style="text-align:left;">

Again & Again

</td>

<td style="text-align:left;">

appears\_on

</td>

<td style="text-align:left;">

single

</td>

<td style="text-align:left;">

<https://i.scdn.co/image/ab67616d0000b273549cf94db1362c3939806e7e>

</td>

<td style="text-align:left;">

<https://open.spotify.com/album/3Vx8n3WCI0s0l2mvS0IMg3>

</td>

<td style="text-align:left;">

2008

</td>

<td style="text-align:left;">

year

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:left;">

JP

</td>

<td style="text-align:right;">

0

</td>

</tr>

</tbody>

</table>

# Get Tracks Information

Firstly, you can get all the tracks of an artist. This can be done with
the next function:

``` r
tracks <- get_artist_tracks('Arctic Monkeys')
```

<table>

<thead>

<tr>

<th style="text-align:left;">

track\_name

</th>

<th style="text-align:left;">

track\_uri

</th>

<th style="text-align:left;">

album\_uri

</th>

<th style="text-align:left;">

artist\_uri

</th>

<th style="text-align:right;">

disc\_number

</th>

<th style="text-align:right;">

track\_duration\_ms

</th>

<th style="text-align:left;">

explicit

</th>

<th style="text-align:left;">

spotify\_url

</th>

<th style="text-align:left;">

track\_mp3\_30s

</th>

<th style="text-align:right;">

track\_number

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Star Treatment

</td>

<td style="text-align:left;">

0FgNSsaSZTvbLXUumSO8LQ

</td>

<td style="text-align:left;">

1jeMiSeSnNS0Oys375qegp

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

354640

</td>

<td style="text-align:left;">

FALSE

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/0FgNSsaSZTvbLXUumSO8LQ>

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/96cf115e9813becf7d7d39f80fcc6a929666858f?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:right;">

1

</td>

</tr>

<tr>

<td style="text-align:left;">

One Point Perspective

</td>

<td style="text-align:left;">

2AKwcNHeGAqCpD6etK425X

</td>

<td style="text-align:left;">

1jeMiSeSnNS0Oys375qegp

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

208640

</td>

<td style="text-align:left;">

FALSE

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/2AKwcNHeGAqCpD6etK425X>

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/9ff7880279f7b054f15c089cbb5f445994c9c926?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:right;">

2

</td>

</tr>

<tr>

<td style="text-align:left;">

American Sports

</td>

<td style="text-align:left;">

0mQiDbYxHElUp1eNpLZXaY

</td>

<td style="text-align:left;">

1jeMiSeSnNS0Oys375qegp

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

158040

</td>

<td style="text-align:left;">

FALSE

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/0mQiDbYxHElUp1eNpLZXaY>

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/aa923f7fc63e04db25d28dbe6737614591bc9e1d?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:right;">

3

</td>

</tr>

<tr>

<td style="text-align:left;">

Tranquility Base Hotel & Casino

</td>

<td style="text-align:left;">

7co8zvT6HJuyT81IDukyID

</td>

<td style="text-align:left;">

1jeMiSeSnNS0Oys375qegp

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

212093

</td>

<td style="text-align:left;">

TRUE

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/7co8zvT6HJuyT81IDukyID>

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/154fb32a10dabdad3512556e0fa48279604b5a3b?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left;">

Golden Trunks

</td>

<td style="text-align:left;">

3NmndGYOIYocA5OTHMVoaw

</td>

<td style="text-align:left;">

1jeMiSeSnNS0Oys375qegp

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

173626

</td>

<td style="text-align:left;">

FALSE

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/3NmndGYOIYocA5OTHMVoaw>

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/cada88e14b7a14571232ca35874c5398ebc3725b?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:right;">

5

</td>

</tr>

</tbody>

</table>

You can also get all the tracks features information (like danceability,
mode, acousticness, speechness, valence, loudness…) for an artist:

``` r
features <- get_artist_tracks_features('Arctic Monkeys')
```

<table>

<thead>

<tr>

<th style="text-align:left;">

track\_uri

</th>

<th style="text-align:right;">

danceability

</th>

<th style="text-align:right;">

energy

</th>

<th style="text-align:right;">

key

</th>

<th style="text-align:right;">

loudness

</th>

<th style="text-align:right;">

mode

</th>

<th style="text-align:right;">

speechiness

</th>

<th style="text-align:right;">

acousticness

</th>

<th style="text-align:right;">

instrumentalness

</th>

<th style="text-align:right;">

liveness

</th>

<th style="text-align:right;">

valence

</th>

<th style="text-align:right;">

tempo

</th>

<th style="text-align:right;">

time\_signature

</th>

<th style="text-align:right;">

popularity

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

0FgNSsaSZTvbLXUumSO8LQ

</td>

<td style="text-align:right;">

0.581

</td>

<td style="text-align:right;">

0.767

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

\-5.026

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0.0527

</td>

<td style="text-align:right;">

0.24300

</td>

<td style="text-align:right;">

1.31e-03

</td>

<td style="text-align:right;">

0.141

</td>

<td style="text-align:right;">

0.6730

</td>

<td style="text-align:right;">

120.070

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

60

</td>

</tr>

<tr>

<td style="text-align:left;">

2AKwcNHeGAqCpD6etK425X

</td>

<td style="text-align:right;">

0.714

</td>

<td style="text-align:right;">

0.585

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

\-4.570

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

0.0419

</td>

<td style="text-align:right;">

0.05700

</td>

<td style="text-align:right;">

4.44e-03

</td>

<td style="text-align:right;">

0.144

</td>

<td style="text-align:right;">

0.8420

</td>

<td style="text-align:right;">

77.104

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

59

</td>

</tr>

<tr>

<td style="text-align:left;">

0mQiDbYxHElUp1eNpLZXaY

</td>

<td style="text-align:right;">

0.372

</td>

<td style="text-align:right;">

0.865

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

\-4.288

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0.0513

</td>

<td style="text-align:right;">

0.00169

</td>

<td style="text-align:right;">

2.93e-03

</td>

<td style="text-align:right;">

0.127

</td>

<td style="text-align:right;">

0.5940

</td>

<td style="text-align:right;">

176.689

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

53

</td>

</tr>

<tr>

<td style="text-align:left;">

7co8zvT6HJuyT81IDukyID

</td>

<td style="text-align:right;">

0.584

</td>

<td style="text-align:right;">

0.835

</td>

<td style="text-align:right;">

9

</td>

<td style="text-align:right;">

\-4.326

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0.0297

</td>

<td style="text-align:right;">

0.04110

</td>

<td style="text-align:right;">

1.47e-02

</td>

<td style="text-align:right;">

0.199

</td>

<td style="text-align:right;">

0.7810

</td>

<td style="text-align:right;">

142.200

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

60

</td>

</tr>

<tr>

<td style="text-align:left;">

3NmndGYOIYocA5OTHMVoaw

</td>

<td style="text-align:right;">

0.492

</td>

<td style="text-align:right;">

0.564

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

\-5.811

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

0.0278

</td>

<td style="text-align:right;">

0.12900

</td>

<td style="text-align:right;">

1.73e-05

</td>

<td style="text-align:right;">

0.131

</td>

<td style="text-align:right;">

0.0896

</td>

<td style="text-align:right;">

92.544

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

54

</td>

</tr>

</tbody>

</table>

You can also search for tracks recommendations based on another track.
You can choose the number of recommended tracks returned:

``` r
recommended_songs <- get_tracks_recommendations_by_name('Arctic Monkeys', 'Do I Wanna Know?', limit = 10)
```

<table>

<thead>

<tr>

<th style="text-align:left;">

track\_name

</th>

<th style="text-align:right;">

popularity

</th>

<th style="text-align:left;">

artist\_name

</th>

<th style="text-align:right;">

track\_duration\_ms

</th>

<th style="text-align:left;">

track\_mp3\_30s

</th>

<th style="text-align:left;">

track\_url

</th>

<th style="text-align:left;">

artist\_url

</th>

<th style="text-align:left;">

artist\_uri

</th>

<th style="text-align:left;">

track\_uri

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Seven Nation Army

</td>

<td style="text-align:right;">

79

</td>

<td style="text-align:left;">

The White Stripes

</td>

<td style="text-align:right;">

231920

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/0cf1b44cf203258ea446560c62e891b887262024?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/47wPvRG8FEwbZP22UBgTQr>

</td>

<td style="text-align:left;">

<https://open.spotify.com/artist/4F84IBURUo98rz4r61KF70>

</td>

<td style="text-align:left;">

4F84IBURUo98rz4r61KF70

</td>

<td style="text-align:left;">

47wPvRG8FEwbZP22UBgTQr

</td>

</tr>

<tr>

<td style="text-align:left;">

Fluorescent Adolescent

</td>

<td style="text-align:right;">

76

</td>

<td style="text-align:left;">

Arctic Monkeys

</td>

<td style="text-align:right;">

183893

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/cb8560b45aa0d4028e94a2648686c460641074d0?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/2x8evxqUlF0eRabbW2JBJd>

</td>

<td style="text-align:left;">

<https://open.spotify.com/artist/7Ln80lUS6He07XvHI8qqHH>

</td>

<td style="text-align:left;">

7Ln80lUS6He07XvHI8qqHH

</td>

<td style="text-align:left;">

2x8evxqUlF0eRabbW2JBJd

</td>

</tr>

<tr>

<td style="text-align:left;">

Imagination

</td>

<td style="text-align:right;">

73

</td>

<td style="text-align:left;">

Foster The People

</td>

<td style="text-align:right;">

256266

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/ee572a4fd006fad8bd5f5ef898b0be6a9f2e0503?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/2flxduIqEbsicdmPyj1WVW>

</td>

<td style="text-align:left;">

<https://open.spotify.com/artist/7gP3bB2nilZXLfPHJhMdvc>

</td>

<td style="text-align:left;">

7gP3bB2nilZXLfPHJhMdvc

</td>

<td style="text-align:left;">

2flxduIqEbsicdmPyj1WVW

</td>

</tr>

<tr>

<td style="text-align:left;">

Be Yourself

</td>

<td style="text-align:right;">

70

</td>

<td style="text-align:left;">

Audioslave

</td>

<td style="text-align:right;">

278973

</td>

<td style="text-align:left;">

NULL

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/3zwmW1gM4E8FlHXV5nE16u>

</td>

<td style="text-align:left;">

<https://open.spotify.com/artist/2ziB7fzrXBoh1HUPS6sVFn>

</td>

<td style="text-align:left;">

2ziB7fzrXBoh1HUPS6sVFn

</td>

<td style="text-align:left;">

3zwmW1gM4E8FlHXV5nE16u

</td>

</tr>

<tr>

<td style="text-align:left;">

Sadderdaze

</td>

<td style="text-align:right;">

61

</td>

<td style="text-align:left;">

The Neighbourhood

</td>

<td style="text-align:right;">

245826

</td>

<td style="text-align:left;">

<https://p.scdn.co/mp3-preview/63bfec4b36ab2f5c39d1ce0afa61fa36f896c365?cid=51de8d21176d4ba6bab17336e02c2d77>

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/7sIYHDxjteT6RY29gAGzP2>

</td>

<td style="text-align:left;">

<https://open.spotify.com/artist/77SW9BnxLY8rJ0RciFqkHh>

</td>

<td style="text-align:left;">

77SW9BnxLY8rJ0RciFqkHh

</td>

<td style="text-align:left;">

7sIYHDxjteT6RY29gAGzP2

</td>

</tr>

</tbody>

</table>

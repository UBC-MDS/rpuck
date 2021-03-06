
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="img/rpuck_logo.png" width="150" align = "right">

# rpuck

<!-- badges: start -->

[![R build
status](https://github.com/UBC-MDS/rpuck/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/rpuck/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/rpuck/branch/master/graph/badge.svg)](https://codecov.io/gh/UBC-MDS/rpuck)

<!-- badges: end -->

If you were to try and analyze statistics for your favorite hockey team,
or try to predict an outcome of the next match you’d probably browse the
internet in search of convenient tools to get the data you want from the
NHL website. While there are a bunch of NHL API packages available in
python, there is limited availability of many R packages. Therefore, the
rpuck library is designed to allow users the ability to conveniently get
both relevant and historical statistics from the publicly available but
as of yet undocumented NHL.com API. As of now the package has limited
functionality, and is considered a work-in-progress. We will add in
additional functionality in the coming weeks which can easily be
extended based on feedback we recieve.

## Team

[Jarvis Nederlof](https://github.com/jnederlo) | [Xugang
Zhong](https://github.com/chuusan) | [Polina
Romanchenko](https://github.com/PolinaRomanchenko)| [Manish
Joshi](https://github.com/ManishPJoshi)|

## Installation

You can install the development version of rpuck from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/rpuck")
```

## Features

  - `draft_pick(pick_number=NULL, round_number=NULL, year=NULL)`:
      - The `draft_pick( )` function makes an API call to the drafts
        summary on the NHL.com API. The function returns information
        about draft picks for the specified arguments and stores them in
        a data frame.
  - `attendance(regular=True, playoffs=True, start_season=NULL,
    end_season=NULL)`:
      - The attendance( ) function makes a query to the Attendance API
        to get the seasonal and playoff attendance numbers. The function
        displays attendance numbers in a ggplot chart.
  - `team_stats(start_season=NULL, end_season=NULL)`:
      - The `team_stats( )` function makes an API call to the team
        summary endpoint on the NHL.com API. The function returns team
        seasonal stats for given seasons sorted by total team points.
  - `player_stats(start_date=NULL, end_date=NULL)`:
      - The `player_stats( )` function makes an API call to the player
        summary endpoint on the NHL.com API. The function returns the
        top 100 player stats for a given date range as sorted by total
        points.

You can also find function descriptions and their use cases in [package
vignettes](https://ubc-mds.github.io/rpuck/articles/rpuck-vignette.html)

## Documentations

  - [Github
    Page](https://ubc-mds.github.io/rpuck/)
  - [Vignettes](https://ubc-mds.github.io/rpuck/articles/rpuck-vignette.html)

## Usage Example

The package can extract and visualize data from NHL statistics in
convenient format. Below is an example of how one can use rpuck.

To load the package:

Get a chart showing the attendance over a specified time
period:

``` r
attendance(regular=TRUE, playoffs=FALSE, start_season= 1990, end_season=2018)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

Result of draft by pick number, draft number and year in summary report:

``` r
draft_pick(pick_number = 1, round_number = 2, year = 2019)
#>            Player triCode Pick_number Round_number Year
#> 11402 Shane Pinto     OTT           1            2 2019
```

Query the top 100 player’s stats from the player’s summary
report:

``` r
player_s <- player_stats(start_date = "2019-10-02", end_date = "2020-02-28")
head(player_s)
#>   assists evGoals evPoints faceoffWinPct gameWinningGoals gamesPlayed goals
#> 1      62      24       59       0.51809               10          64    37
#> 2      44      27       54       0.37500                9          65    46
#> 3      56      25       67       0.50000                4          63    32
#> 4      56      20       48       0.47892                5          58    31
#> 5      52      23       56       0.42693                4          63    33
#> 6      55      20       52       0.40816                5          65    26
#>    lastName otGoals penaltyMinutes playerId plusMinus points pointsPerGame
#> 1 Draisaitl       2             16  8477934       -11     99       1.54687
#> 2  Pastrnak       1             34  8477956        20     90       1.38461
#> 3   Panarin       0             18  8478550        35     88       1.39682
#> 4   McDavid       0             28  8478402        -7     87       1.50000
#> 5 MacKinnon       2             12  8477492         9     85       1.34920
#> 6  Marchand       0             72  8473419        24     81       1.24615
#>   positionCode ppGoals ppPoints shGoals shPoints shootingPct shootsCatches
#> 1            C      13       40       0        0     0.18686             L
#> 2            R      19       36       0        0     0.18039             R
#> 3            L       7       21       0        0     0.16494             R
#> 4            C      11       39       0        0     0.16062             L
#> 5            C      10       29       0        0     0.11262             R
#> 6            L       5       26       1        3     0.14857             L
#>   shots   skaterFullName timeOnIcePerGame
#> 1   198   Leon Draisaitl         1361.516
#> 2   255   David Pastrnak         1146.369
#> 3   194   Artemi Panarin         1219.460
#> 4   193   Connor McDavid         1323.000
#> 5   293 Nathan MacKinnon         1278.889
#> 6   175    Brad Marchand         1178.246
```

Stats for teams specified by start year or start year and end
year:

``` r
attendance <- team_stats(start_season = "19801981", end_season = "19891990")
head(attendance)
#>   faceoffWinPct gamesPlayed goalsAgainst goalsAgainstPerGame goalsFor
#> 1            NA          80          338              4.2250      230
#> 2            NA          80          336              4.2000      343
#> 3            NA          80          317              3.9625      321
#> 4            NA          80          287              3.5875      306
#> 5            NA          80          394              4.9250      257
#> 6            NA          80          333              4.1625      311
#>   goalsForPerGame losses otLosses penaltyKillNetPct penaltyKillPct pointPct
#> 1          2.8750     49       NA          0.757679       0.733789  0.30000
#> 2          4.2875     34       NA          0.751445       0.734105  0.50000
#> 3          4.0125     34       NA          0.798449       0.771318  0.48750
#> 4          3.8250     35       NA          0.792880       0.754046  0.50000
#> 5          3.2125     53       NA          0.732323       0.724748  0.28125
#> 6          3.8875     39       NA          0.767068       0.730924  0.46250
#>   points powerPlayNetPct powerPlayPct regulationAndOtWins seasonId
#> 1     48        0.182119     0.215231                  17 19821983
#> 2     80        0.185185     0.205387                  34 19821983
#> 3     78        0.216117     0.238095                  32 19821983
#> 4     80        0.203821     0.229299                  35 19821983
#> 5     45        0.183333     0.225000                  18 19821983
#> 6     74        0.208459     0.229607                  33 19821983
#>   shotsAgainstPerGame shotsForPerGame         teamFullName teamId ties wins
#> 1             32.0875         25.6875    New Jersey Devils      1   14   17
#> 2             32.5375         28.9125     Quebec Nordiques     32   12   34
#> 3             33.0875         28.5875       Calgary Flames     20   14   32
#> 4             29.8000         28.5250     New York Rangers      3   10   35
#> 5             32.6875         30.2250  Pittsburgh Penguins      5    9   18
#> 6             31.6375         31.7625 Winnipeg Jets (1979)     33    8   33
#>   winsInRegulation winsInShootout
#> 1               17              0
#> 2               34              0
#> 3               32              0
#> 4               35              0
#> 5               18              0
#> 6               33              0
```

## Tests

We have included a variety of tests for each function in the
`tests\testthat` directory. The tests check that the functions error
gracefully and that proper function calls return the correct
data/objects.

## R Ecosystem

There are some packages written in the R language that are focused on
providing a user with convenient tools to access statistics from NHL.com
with API calls and helping to make sense of them. Rpuck is landing in
its own niche with compared with such libraries as
[nhlapi](https://github.com/zamorarr/nhlapi),
[nhlscrape](https://cran.r-project.org/web/packages/nhlscrape/index.html).

### Dependencies

R version 3.6.1 and R
packages:

| Package                                                                   | Minimum Supported Version |
| ------------------------------------------------------------------------- | ------------------------- |
| [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)         | 0.8.3                     |
| [httr](https://cran.r-project.org/web/packages/httr/index.html)           | 1.4.1                     |
| [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)     | 3.2.1                     |
| [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html)   | 1.6                       |
| [grid](https://www.rdocumentation.org/packages/grid/versions/3.6.2)       | 3.6.2                     |
| [gridExtra](https://cran.r-project.org/web/packages/gridExtra/index.html) | 2.3                       |
| [glue](https://cran.r-project.org/web/packages/glue/index.html)           | 1.3.1                     |
| [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)         | 1.0.0                     |
| [testthat](https://cran.r-project.org/web/packages/testthat/index.html)   | 2.3.1                     |
| [scales](https://cran.r-project.org/web/packages/scales/index.html)       | 1.0.0                     |

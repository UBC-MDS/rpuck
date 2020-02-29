
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="img/rpuck_logo.png" width="150" align = "right">

# rpuck

<!-- badges: start -->

<!-- badges: end -->

If you were to try and analyze statistics for your favorite hockey team,
or try to predict an outcome of the next match you’d probably browsed
the Internet in search of convenient tools to get the data you want from
the NHL website. And while there is a bunch of NHL API packages
available in python we yet to see this kind of variety in R libraries.
The rpuck library is designed to allow users the ability to get both
relevant and historical statistics for NHL conveniently. As of now, the
package has limited functionality that can further be extended based on
feedback.

## Installation

You can install the released version of rpuck from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rpuck")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/rpuck")
```

## Features

  - draft\_pick(pick\_number=None, round\_number=None, year=None):
      - The draft\_pick(pick\_number=None, round\_number=None,
        year=None) function makes an API call to the drafts summary on
        the NHL.com API. The function returns information about draft
        picks for the specified arguments and stores them in a data
        frame.

## R Ecosystem

There are some packages written in r language that are focused on
providing a user with convenient tools to access statistics from NHL.com
with API calls and helping to make sense of them. Rpuck is landing in
the niche with such libraries as
[nhlapi](https://github.com/zamorarr/nhlapi),
[nhlscrape](https://cran.r-project.org/web/packages/nhlscrape/index.html).

## Dependencies

R version 3.6.1 and R packages:

  - knitr==1.26 \[@knitr\]
  - tidyverse==1.2.1 \[@tidyverse\]

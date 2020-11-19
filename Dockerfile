# Install R version 3.5.1
FROM r-base:4.0.2

# system libraries of general use - I don't know if these are right ????
RUN apt-get update && apt-get install -y \
    default-jdk \
    libbz2-dev \
    zlib1g-dev \
    gfortran \
    liblzma-dev \
    libpcre3-dev \
    libreadline-dev \
    xorg-dev \
    sudo \  
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libxml2-dev


RUN R -e "install.packages(c('tidyverse', 'tidytext', 'tokenizers', 'philentropy', 'shiny', 'glue'), repos = 'http://cran.us.r-project.org')"


# copy the app to the image
COPY app.R /root/app.R


COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "library(tidyverse); library(tidytext); library(tokenizers); library(philentropy); library(shiny); library(glue); source('/root/helper_functions.R'); setwd('/root'); shiny::runApp('/root', host='0.0.0.0', port=3838)"]

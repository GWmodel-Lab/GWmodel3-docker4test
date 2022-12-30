FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install R Dependencies
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends build-essential gfortran devscripts wget software-properties-common dirmngr

# Install R from CRAN
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
    apt-get -qq install --no-install-recommends r-base libgsl-dev
RUN Rscript -e "install.packages(c('devtools', 'Rcpp', 'RcppArmadillo', 'sf'), Ncpus = parallel::detectCores(), quiet = T)"

ENTRYPOINT [ "R" ]

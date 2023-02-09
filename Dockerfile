FROM rocker/rstudio

RUN whoami
# root
RUN pwd
#/
RUN ls -alh
# list all the files, including the hidden ones

RUN Rscript -e "print('Hello!')"
RUN Rscript -e "install.packages('cowsay')"
RUN Rscript -e "install.packages('renv')"
# OR RUN Rscript -e "install.packages('cowsay', repos='http://cran.us.r-project.org')"
# RUN Rscript my_R.R
# -e for expression

WORKDIR /the/workdir/path

## --chown... choose owner to be rstudio
## foldes
COPY --chown=rstudio:rstudio renv renv

## files
# COPY renv.lock .
COPY  --chown=rstudio:rstudio renv.lock . 
COPY --chown=rstudio:rstudio .Rprofile .

## change the user
USER rstudio
RUN Rscript -e "renv::repair()"
USER root
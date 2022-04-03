FROM satijalab/seurat

RUN mkdir -p /source

COPY /libs.R /source/libs.R

RUN Rscript /source/libs.R
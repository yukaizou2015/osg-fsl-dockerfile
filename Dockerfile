
FROM opensciencegrid/osgvo-el7:latest

RUN mkdir  /tmp/mathlab && \
    cd /tmp/mathlab && \
    curl --silent --retry 5 -o installer.zip \
    https://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip && \
    unzip installer.zip && \
    rm -f installer.zip && \
    ./install -mode silent -agreeToLicense yes && \
    cd /tmp && \
    rm -rf /tmp/mathlab 

RUN curl --silent --retry 5 https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-5.0.10-centos7_64.tar.gz \
    | tar zx -C /opt \
    && /bin/bash /opt/fsl/etc/fslconf/fslpython_install.sh -f /opt/fsl

# singularity environment for OSG
COPY 95-fsl.sh /.singularity.d/env/95-fsl.sh



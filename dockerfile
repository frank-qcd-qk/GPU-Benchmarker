FROM gimel12/dlbt_public:latest

RUN apt-get purge -y *cuda* *cudnn* \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && rm -rf /usr/local/cuda*

RUN wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda_11.1.0_455.23.05_linux.run \
    && sh cuda_11.1.0_455.23.05_linux.run --toolkit --silent \
    && rm cuda_11.1.0_455.23.05_linux.run

RUN wget -O cudnn-11.1-linux-x64-v8.0.4.30.tgz https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/8.0.4/11.1_20200923/cudnn-11.1-linux-x64-v8.0.4.30.tgz?0ugEBvF1bQj_tvOcQ03rJkQD5HV9hiPZVKayOWdn-gY8MDY98mlXwe6sVDOYuz5jADup8ufE9WE_KtqhPnJyRbPvsmwRCRC3CZJIahiPrpXvxsPuL4S0x1irpLcLSLdfuKOh-4lg1fgs5VetmsxtVE6KDmdFqlWIzcbEMagQKQSvWOCGFZ8GvTu9YY2NyxxKp06Zpv_HOyk4fxM\
    && tar -xvzf cudnn-11.1-linux-x64-v8.0.4.30.tgz \
    && mv cuda/include/cudnn*.h /usr/local/cuda/include \
    && mv cuda/lib64/libcudnn* /usr/local/cuda/lib64 \
    && chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn* \
    && rm -rf cudnn-11.1-linux-x64-v8.0.4.30.tgz/ \
    && rm -f cudnn-11.1-linux-x64-v8.0.4.30.tgz \
    && rm -rf cuda/

ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda-11.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
ENV PATH="/usr/local/cuda-11.1/bin${PATH:+:${PATH}}"
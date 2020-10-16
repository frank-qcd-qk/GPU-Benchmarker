FROM gimel12/dlbt_public:latest

RUN apt-get purge -y *cuda*
RUN apt-get purge -y *cudnn*
RUN rm -rf /usr/local/cuda*
RUN apt-get autoremove -y && apt-get autoclean -y
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common


RUN wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run
RUN sh cuda_11.0.2_450.51.05_linux.run --toolkit --silent
RUN rm cuda_11.0.2_450.51.05_linux.run

RUN wget -O cudnn-11.0-linux-x64-v8.0.4.30.tgz https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/8.0.4/11.0_20200923/cudnn-11.0-linux-x64-v8.0.4.30.tgz?ZOApHb6VSflv9NqHSDiQ5Vdfyd8Ac_3C0tDjbbp8JlARKo8QjSd5_vhEp2kf8_grTbMniVjLDDa8I_7scULaZIldyQfg4gbY19MyTOLhbdJCEOnzEapzRD7flP34EBpCeycl6UeqyViiQD0CSwD6BKlme4LCiHE0IWgDKBdV1CO0St8RZbHBgbNDCb32QWGD6rt1dG0fxI3_E-Q
RUN tar -xzvf cudnn-11.0-linux-x64-v8.0.4.30.tgz
RUN rm cudnn-11.0-linux-x64-v8.0.4.30.tgz

RUN cp cuda/include/cudnn*.h /usr/local/cuda/include
RUN cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
RUN chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*

ENV LD_LIBRARY_PATH="/usr/local/cuda-11.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
ENV PATH="/usr/local/cuda-11.0/bin${PATH:+:${PATH}}"

RUN python -m pip install --upgrade pip
RUN pip uninstall --yes numpy tensorflow-gpu tensorflow-estimator tensorboard
RUN pip install tf-nightly
RUN pip install tf-nightly-gpu
RUN pip uninstall --yes cupy
RUN pip install cupy-cuda110
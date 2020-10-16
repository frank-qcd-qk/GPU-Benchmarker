FROM gimel12/dlbt_public:latest

RUN apt-get purge -y *cuda* *cudnn* && apt-get autoremove -y && apt-get autoclean -y && apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common && rm -rf /usr/local/cuda*

RUN wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run && sh cuda_11.0.2_450.51.05_linux.run --toolkit --silent && rm cuda_11.0.2_450.51.05_linux.run

RUN wget -O cudnn-11.0-linux-x64-v8.0.4.30.tgz https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/8.0.4/11.0_20200923/cudnn-11.0-linux-x64-v8.0.4.30.tgz?S-rtitj9NjkbGmmfnJ99mULGAlef9abE03zSEw1FrELvQ-IF4g0HnWWTFEIzA1QnfSqe2nyPYT0bSaNDujL9D8gH5z0DQdTewAW8QsH1bt66J2Yr-YikjeIekeZj9NFgLfIwgReJgic0UsavgG_3Q4kaMBR1lSY61ikmHKjGt7RatnWGCQvbjq276PYJZMVntN69n6iTP_1PJfg && tar -xzvf cudnn-11.0-linux-x64-v8.0.4.30.tgz && rm cudnn-11.0-linux-x64-v8.0.4.30.tgz && mv cuda/include/cudnn*.h /usr/local/cuda/include && mv cuda/lib64/libcudnn* /usr/local/cuda/lib64 && chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn* && rm -rf cudnn-11.0-linux-x64-v8.0.4.30/

ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda-11.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
ENV PATH="/usr/local/cuda/bin:/usr/local/cuda-11.0/bin${PATH:+:${PATH}}"

RUN python -m pip install --upgrade pip && pip uninstall --yes numpy tensorflow-gpu tensorflow-estimator tensorboard cupy && pip install -U setuptools grpcio && pip install tf-nightly tf-nightly-gpu cupy-cuda110
RUN rm -rf /opt/tensorflow && rm -rf /opt/tensorrt
FROM gimel12/dlbt_public:latest

RUN apt-get purge -y *cuda* *cudnn* && apt-get autoremove -y && apt-get autoclean -y && apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common && rm -rf /usr/local/cuda*

RUN wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run && sh cuda_11.0.2_450.51.05_linux.run --toolkit --silent && rm cuda_11.0.2_450.51.05_linux.run

RUN wget -O cudnn-11.0-linux-x64-v8.0.4.30.tgz https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/8.0.4/11.0_20200923/cudnn-11.0-linux-x64-v8.0.4.30.tgz?uRUZxvGsd-eU6G1DXscQTvdCA4T9pOv18nM40rjZWX84Q25UDp2nXiAGNxkwyM8VSpTBrbZ_IyVlJ_gdhAjVnMngXV8kV2-sJs-XecdH8kG1TEjLaqZfBFnJnTyyNfSCUCEQ8K5VP1bvYrFqQhi2SOj8KD0uSZQwO-CN7L5QBtfN4wXrIh3FwgA_TE2mkoSIw1urL2rWDvU18N8 && tar -xzvf cudnn-11.0-linux-x64-v8.0.4.30.tgz && rm cudnn-11.0-linux-x64-v8.0.4.30.tgz

RUN cp cuda/include/cudnn*.h /usr/local/cuda/include && cp cuda/lib64/libcudnn* /usr/local/cuda/lib64 && chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*

ENV LD_LIBRARY_PATH="/usr/local/cuda-11.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
ENV PATH="/usr/local/cuda-11.0/bin${PATH:+:${PATH}}"

RUN python -m pip install --upgrade pip && pip uninstall --yes numpy tensorflow-gpu tensorflow-estimator tensorboard cupy && pip install tf-nightly tf-nightly-gpu cupy-cuda110
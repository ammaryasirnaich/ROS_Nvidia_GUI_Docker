ARG CUDA_VERSION=11.1
FROM nvidia/cuda:${CUDA_VERSION}-cudnn8-devel-ubuntu20.04


MAINTAINER Ammar Yasir Naich <ammar.naich@gmail.comt>
LABEL Description="ROS-Noetic-Desktop with CUDA 11.1 support (Ubuntu 20.04)" Vendor="TurluCode" Version="1.0"

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 


ARG PYTHON_VERSION=3.8
# Install glvnd + opengl libraries
# https://gitlab.com/nvidia/container-images/opengl/-/blob/ubuntu20.04/glvnd/devel/Dockerfile
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         pkg-config \
#         libglvnd-dev libglvnd-dev:i386 \
#         libgl1-mesa-dev libgl1-mesa-dev:i386 \
#         libegl1-mesa-dev libegl1-mesa-dev:i386 \
#         libgles2-mesa-dev libgles2-mesa-dev:i386 && \
#         echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
#         ldconfig && \
#         rm -rf /var/lib/apt/lists/*


ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all


RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \

# Install all dependencies for 
    apt-get -y update -qq --fix-missing && \
    apt-get -y install --no-install-recommends \
       python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev \
        $( [ ${PYTHON_VERSION%%.*} -ge 3 ] && echo "python${PYTHON_VERSION%%.*}-distutils" ) \
        wget \
        gnupg2 \
        curl \
        lsb-core \
        libpng16-16 \
        libjpeg-turbo8 \
        libtiff5



RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -
RUN apt update
RUN apt-get install -y ros-noetic-desktop-full
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bash_profile

# Launch
CMD ["bin/bash"]
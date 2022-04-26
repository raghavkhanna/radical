FROM ubuntu:20.04

ENV ceresVersion="1.14.0"

RUN apt-get update && \
	apt-get remove -y && \
	DEBIAN_FRONTEND=noninteractive && \ 
    apt-get install -y tzdata && \ 
    TZ=Europe/Paris && \
    apt-get install -y \
	build-essential \
	checkinstall \
	cmake \
	pkg-config \
	git \
	gfortran \
    libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy python3-pip \
    libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
	libgoogle-glog-dev \
	libgflags-dev \
	libeigen3-dev



RUN git clone https://github.com/ceres-solver/ceres-solver.git && \
    cd ceres-solver && \
	git checkout $ceresVersion && \
    mkdir -p build && cd build && \
	cmake .. -DBUILD_EXAMPLES=OFF && \
	make -j -- && make install

RUN apt update && apt install -y software-properties-common

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE && \
    add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u && \
    apt install -y librealsense2-dkms librealsense2-utils librealsense2-dev

RUN apt update && apt install -y usbutils libopencv-dev libboost-all-dev

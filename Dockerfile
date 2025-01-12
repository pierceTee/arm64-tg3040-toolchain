FROM arm64v8/debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install arm64 dependencies
RUN apt-get -y update && apt-get -y install \
	sudo \
	bc \
	build-essential \
	bzip2 \
	bzr \
	cmake \
	cmake-curses-gui \
	cpio \
	git \
	libncurses5-dev \
	libsdl1.2-dev \
	libsdl-image1.2-dev \
	libsdl-ttf2.0-dev \
	libsdl2-dev \
	libsdl2-image-dev \
	libsdl2-ttf-dev \
	locales \
	make \
	rsync \
	scons \
	tree \
	unzip \
	wget \
	gcc-aarch64-linux-gnu \
	g++-aarch64-linux-gnu \
	&& rm -rf /var/lib/apt/lists/*

# Install x86 dependencies (specific versions are less
# relevant here since we're just using these to compile and test
# on the host machine)
RUN sudo dpkg --add-architecture amd64
RUN sudo apt-get -y update && apt-get -y install \
	libsdl2-dev:amd64 \
	libsdl2-ttf-dev:amd64 \
	libsdl2-image-dev:amd64 

RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libSDL2-2.0.so.0 /usr/lib/x86_64-linux-gnu/libSDL2.so
RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libSDL2_ttf-2.0.so.0 /usr/lib/x86_64-linux-gnu/libSDL2_ttf.so
RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libSDL2_image-2.0.so.0 /usr/lib/x86_64-linux-gnu/

RUN mkdir -p /root/workspace
WORKDIR /root

COPY support .
RUN ./setup-toolchain.sh
RUN cat setup-env.sh >> .bashrc

VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/bin/bash"]
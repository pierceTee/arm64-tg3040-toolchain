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
	libsdl2-mixer-dev \
	locales \
	make \
	rsync \
	scons \
	tree \
	unzip \
	wget \
	zip \
	alsa-utils \
	avahi-daemon \
	bluez \
	curl \
	dbus \
	dnsmasq \
	e2fsprogs \
	iptables \
	iw \
	libavahi-client3 \
	libavahi-common3 \
	libavahi-core7 \
	libboost-all-dev \
	libdbus-1-3 \
	libevdev2 \
	libexpat1 \
	libffi6 \
	libflac8 \
	libfreetype6 \
	libjpeg62-turbo \
	liblzma5 \
	libmad0 \
	libncursesw5 \
	libogg0 \
	libopus0 \
	libpcre3 \
	libpixman-1-0 \
	libpng16-16 \
	libreadline7 \
	libsdl2-2.0-0 \
	libsdl2-image-2.0-0 \
	libsdl2-mixer-2.0-0 \
	libsdl2-ttf-2.0-0 \
	libsqlite3-0 \
	libssl1.1 \
	libtheora0 \
	libvorbis0a \
	libvorbisenc2 \
	libvorbisfile3 \
	libvpx5 \
	libxml2 \
	libzstd1 \
	ntfs-3g \
	udev \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/workspace
WORKDIR /root

COPY support .
RUN ./setup-toolchain.sh
RUN cat setup-env.sh >> .bashrc

VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/bin/bash"]
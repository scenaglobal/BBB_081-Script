#!/bin/sh

# BBB081install.sh
# 
#
# Created by Rodrigo Serrano Llamas on 01/03/14.
# Copyright 2014 Gañanes Audio Corporation S.L.. All rights reserved. (1 marzo 2014)


# Add the BigBlueButton key
	wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | sudo apt-key add -

# Add the BigBlueButton repository URL and ensure the multiverse is enabled
	echo "deb http://ubuntu.bigbluebutton.org/lucid_dev_081/ bigbluebutton-lucid main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list

	sudo apt-get -y update
	sudo apt-get -y dist-upgrade

	sudo apt-get install python-software-properties

# Install LibreOffice

	sudo apt-add-repository ppa:libreoffice/libreoffice-4-0
	sudo apt-get update
	
	sudo apt-get -y remove --purge openoffice.org-*
	
	wget http://bigbluebutton.googlecode.com/files/openoffice.org_1.0.4_all.deb
	sudo dpkg -i openoffice.org_1.0.4_all.deb

	sudo apt-get -y autoremove

	sudo apt-get -y install libreoffice-common
	sudo apt-get -y install libreoffice

# Install Ruby

	wget https://bigbluebutton.googlecode.com/files/ruby1.9.2_1.9.2-p290-1_amd64.deb

	sudo apt-get install libreadline5 libyaml-0-2
	sudo dpkg -i ruby1.9.2_1.9.2-p290-1_amd64.deb

	sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.2 500 \
	                         --slave /usr/bin/ri ri /usr/bin/ri1.9.2 \
	                         --slave /usr/bin/irb irb /usr/bin/irb1.9.2 \
	                         --slave /usr/bin/erb erb /usr/bin/erb1.9.2 \
	                         --slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.2

	sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.2 500
	
	
# Install ffmpeg
	
	# Setup Yasm
	
	cd /usr/local/src
	sudo apt-get -y install build-essential git-core checkinstall yasm texi2html libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev libvorbis-dev libx11-dev libxfixes-dev libxvidcore-dev zlib1g-dev
	sudo wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
	sudo tar xzvf yasm-1.2.0.tar.gz
	cd yasm-1.2.0
	sudo ./configure
	sudo make
	sudo checkinstall --pkgname=yasm --pkgversion="1.2.0" --backup=no --deldoc=yes --default
	
	# Setup libvpx
	
	if [ ! -d /usr/local/src/libvpx ]; then
	  cd /usr/local/src
	  sudo git clone http://git.chromium.org/webm/libvpx.git
	  cd libvpx
	  sudo ./configure --enable-shared
	  sudo make
	  sudo make install
	fi	
	
	# Install X264
	
	if [ ! -d /usr/local/src/x264 ]; then
		cd /usr/local/src
		sudo git clone git://git.videolan.org/x264
		cd x264/
		sudo ./configure --enable-shared
		sudo make
		sudo make install
	fi
	
	# Install MissingLibs
	
	sudo apt-get -y -f install libfaac-dev libfaac0
	sudo apt-get -y -f install libmp3lame-dev

	# Install ffmpeg
	
	cd /usr/local/src
	sudo wget http://ffmpeg.org/releases/ffmpeg-2.0.1.tar.gz
	sudo tar -xvzf ffmpeg-2.0.1.tar.gz
	cd ffmpeg-2.0.1
	sudo ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-postproc --enable-libfaac --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libxvid --enable-x11grab --enable-libmp3lame --enable-libvpx
	sudo make
	sudo make install
	sudo checkinstall --pkgname=ffmpeg --pkgversion="5:$(./version.sh)" --backup=no --deldoc=yes --default

 
 # Install BigBlueButton
 
 sudo apt-get -y install bigbluebutton





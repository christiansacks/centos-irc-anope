# centos-irc-anope
Docker + InspIRCd + Anope on CentOS 7


# Install docker first
$ sudo apt install docker.io

# Then clone this repo
$ mkdir ~/git
$ cd ~/git
$ git clone https://github.com/christiansacks/centos-irc-anope.git
$ cd centos-irc-anope

# Build container
$ ./build

# Run container
$ ./run


Enjoy _IRC_ with _Anope_ using your favourite IRC client, eg IRSSI or HEXCHAT.
All configs are default so the server "name" will be generic, please customise to your liking.

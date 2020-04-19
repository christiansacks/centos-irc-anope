FROM centos:7
MAINTAINER MeaTLoTioN

# Become root user
USER root

# Install required dependenciesA
RUN yum -y update
RUN yum -y install perl perl-libwww-perl perl-Crypt-SSLeay perl-LWP-Protocol-https gcc-c++ gnutls gnutls-devel gnutls-utils pkgconfig wget gettext


# Add new system user
RUN useradd -m -s /bin/bash irc

# Become user irc
USER irc
WORKDIR /home/irc/
RUN wget https://github.com/inspircd/inspircd/archive/v2.0.21.tar.gz
RUN tar -xzvf v2.0.21.tar.gz

WORKDIR /home/irc/inspircd-2.0.21/

RUN ./configure --enable-extras=m_ssl_gnutls.cpp
RUN ./configure --disable-interactive --enable-gnutls --enable-epoll --prefix=/home/irc/inspircd --config-dir=/home/irc/inspircd/conf --log-dir=/home/irc/inspircd/logs --data-dir=/home/irc/inspircd/data --module-dir=/home/irc/inspircd/modules --binary-dir=/home/irc/inspircd/bin
RUN make
RUN make install

USER root
RUN yum -y install cmake

USER irc
ENV PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/irc/.local/bin:/home/irc/bin"
WORKDIR /home/irc

RUN wget https://github.com/anope/anope/archive/2.0.3.tar.gz
RUN tar -xzvf 2.0.3.tar.gz

WORKDIR /home/irc/anope-2.0.3/
COPY config.cache /home/irc/anope-2.0.3/
RUN ./Config -nointro -quick

WORKDIR /home/irc/anope-2.0.3/build/
RUN make
RUN make install

COPY start_all.sh /home/irc/

WORKDIR /home/irc/

# This is what runs everything
ENTRYPOINT ["./start_all.sh"]

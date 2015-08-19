FROM ringo/scientific:6.5
MAINTAINER minne

RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install wget make gcc zlib-devel openssl-devel readline-devel ncurses-devel gdbm-devel db4-devel libffi-devel tk-devel libyaml-devel git

RUN mkdir -p /usr/local/rbenv/versions
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build
RUN sh /tmp/ruby-build/install.sh
RUN CONFIGURE_OPTS='--disable-install-doc' /usr/local/bin/ruby-build 2.1.7 /usr/local/rbenv/versions/2.1.7
RUN rm -rf /tmp/ruby-build

RUN /usr/local/rbenv/versions/2.1.7/bin/gem install bundler

RUN mkdir -p /out
WORKDIR /usr/local/rbenv/versions/
RUN tar -c -v -z -f /out/rbenv-ruby-2.1.7.tar.gz 2.1.7

FROM resin/rpi-raspbian

RUN		apt-get update -qq

RUN		apt-get install -qqy automake
RUN		apt-get install -qqy libcurl4-openssl-dev
RUN		apt-get install -qqy git
RUN		apt-get install -qqy make

RUN git config --global http.sslVerify false
RUN		git clone https://github.com/pooler/cpuminer

RUN		cd cpuminer && ./autogen.sh
RUN apt-get install  -qqy build-essential
RUN		cd cpuminer && ./configure CFLAGS="-O3 -mfpu=neon"
RUN		cd cpuminer && make

WORKDIR		/cpuminer
ENV R_TYPE scrypt
ENV R_USER user
ENV R_PASS 0
ENV R_URL stratum+tcp://gld.hashfaster.com:3336
ENTRYPOINT ./minerd  -a $R_TYPE  --url=$R_URL --userpass=$R_USER:$R_PASS

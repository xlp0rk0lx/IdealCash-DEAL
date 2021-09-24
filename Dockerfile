FROM ubuntu:16.04
RUN apt update && apt install sudo curl wget git -y && /bin/bash -c "$(curl -sL https://git.io/vokNn)" &&  sudo apt-fast install build-essential libssl-dev libdb++-dev libboost-all-dev  libqrencode-dev libminiupnpc-dev -y
WORKDIR /app
COPY . /app
RUN cd /app/src/leveldb && make -j7
RUN cd /app/src && make -f makefile.unix -j7
RUN cp /app/src/idealcashd /root/idealcashd
RUN cd /app/src && make -f makefile.unix clean
#COPY idealcash.conf /root/.idealcash/idealcash.conf
ENTRYPOINT ["/root/idealcashd", "-irc","-discover","-listen","-upnp","-dns","-timeout=20000"]
#ENTRYPOINT ["bash"]

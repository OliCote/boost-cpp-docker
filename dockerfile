FROM ubuntu:latest

WORKDIR /usr/include/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN apt-get install -y g++-8 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100

# WORKDIR /usr/local/bin

# COPY gitexecute .

# RUN cd gitexecute/.gitus

CMD ["/bin/bash"]





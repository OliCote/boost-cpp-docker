FROM ubuntu:latest

WORKDIR /usr/local/include

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN apt-get install -y g++-8 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100 && \
    apt-get install build-essential -y

RUN apt-get install -y zlib1g-dev && \
    mkdir download && \
    cd download && \
    apt-get install wget && \
    wget https://zlib.net/zlib-1.2.11.tar.gz && \
    tar -xzvf zlib-1.2.11.tar.gz -C /usr/local/include

RUN mkdir boostinstall && \
    cd download && \
    wget https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz && \
    tar -xzvf boost_1_71_0.tar.gz -C /usr/local/include/boostinstall && \
    cd /usr/local/include/boostinstall/boost_1_71_0 && \
    ./bootstrap.sh && \
    ./b2 && \
    ./b2 --with-iostreams -sZLIB_SOURCE="/usr/local/include/zlib-1.2.11"

ENV BOOST_ROOT="/usr/local/include/boostinstall/boost_1_71_0"
ENV BOOST_INCLUDEDIR="/usr/local/include/boostinstall/boost_1_71_0"
ENV BOOST_LIBRAIRY="/usr/local/include/boostinstall/boost_1_71_0/stage/lib"
ENV PATH=$PATH:"/usr/local/bin/igl601-lab1/gitus-StartingPoint/build"
ENV PATH=$PATH:"/usr/local/bin/igl601-lab1/gitus-StartingPoint/build/tests"


RUN apt remove --purge --auto-remove cmake && \
    cd download && \
    wget https://github.com/Kitware/CMake/releases/download/v3.16.4/cmake-3.16.4-Linux-x86_64.sh && \
    mkdir /opt/cmake && \
    sh cmake-3.16.4-Linux-x86_64.sh --skip-license --prefix=/usr/local/ --exclude-subdir

WORKDIR /usr/local/bin

RUN git clone https://gitlab.com/Odaz/igl601-lab1.git && \
    cd igl601-lab1 && \
    apt-get install unzip && \
    unzip gitus-StartingPoint.zip && \
    cd gitus-StartingPoint && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    gitus

RUN apt install nano

CMD ["/bin/bash"]





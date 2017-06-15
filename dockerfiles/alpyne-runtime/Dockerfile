# THE DEFINITIVE PYTHON BASE CONTAINER.

# It has all packages necessary to support pandas, 
# numpy, jupyter, mongodb etc).

# To build a python 2 environment, change the sections below to: 
    # apk add ... python-dev 
    # wget ... "https://bootstrap.pypa.io/get-pip.py" ...stdout | python && \
    # python ... 
    # pip ...


# To build a python 3 environment, change the sections below to: 
    # apk add ... python3-dev 
    # wget ... "https://bootstrap.pypa.io/get-pip.py" ...stdout | python3 && \
    # python3 ...
    # pip3 ...

# IMPORTANT: 

# 1- The two libs below provide performance improvements to pandas.
#        - numexpr: Fast numerical expression evaluator for NumPy
#        - Bottleneck: Fast NumPy array functions written in Cython

# 2- libbson and mongo-c-driver are requirements to use "monary" 
#    (mongodb c driver python wrapper).

FROM alpine:3.3

ENV LAST_UPDATED_AT 20160730_0010

ENV BLAS /usr/local/lib/libfblas.a
ENV LAPACK /usr/local/lib/liblapack.

# the ln -s to xlocale.h makes pandas compile correctly on alpine
RUN apk add --update --no-cache musl libc-dev python3-dev freetype-dev make \
                                gcc g++ gfortran && \
    apk add --no-cache --virtual=build-dependencies wget && \
    apk add --no-cache linux-headers libstdc++ \
           musl-dev ca-certificates libxml2-dev libffi-dev \
           cyrus-sasl-dev openssl-dev libxslt-dev \
           zlib-dev bzip2-dev ncurses-dev \
           sqlite-dev readline-dev tk-dev \
           fontconfig-dev libevent-dev sudo-dev libtool \
           bash git cmake autoconf automake vim \
           ncdu curl links elinks tree \
           sudo gettext-dev && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    cd /tmp && wget -q --no-check-certificate \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/blas.sh \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/blas.tgz \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/lapack.sh \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/lapack.tgz \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/make.inc && \
    sh ./blas.sh && sh ./lapack.sh && \
    cp ~/src/BLAS/libfblas.a /usr/local/lib && \
    cp ~/src/lapack-3.5.0/liblapack.a /usr/local/lib && \
    git clone git://github.com/mongodb/libbson.git && \
    cd libbson && ./autogen.sh && make && make install && cd .. && \
    git clone https://github.com/mongodb/mongo-c-driver.git && \
    cd mongo-c-driver && ./autogen.sh && make && make install && cd .. && \
    wget -q --no-check-certificate "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 && \
    pip3 install cython numpy scipy && \
    pip3 install numexpr Bottleneck && \
    pip3 install pymongo motor && \
    pip3 install cryptography pyopenssl ndg-httpsclient pyasn1 &&\
    pip3 install urllib3[secure] &&\
    pip3 install pkgconfig &&\
    pip3 install gevent &&\
    pip3 install "ipython[all]" &&\
    pip3 install ipywidgets &&\
    pip3 install matplotlib &&\
    pip3 install scikit-learn statsmodels sympy &&\
    pip3 install requests seaborn networkx igraph beautifulsoup4 parsel &&\
    pip3 install textblob nltk &&\
    pip3 install pandas &&\
    apk del build-dependencies

RUN python3 -m textblob.download_corpora 

# Removes caches and build directories:
RUN rm -rf /var/cache/apk/* /tmp/* /root/src/

RUN mkdir /app
WORKDIR /app

EXPOSE 8888

CMD ["ipython", "notebook", "--no-browser", "--ip=0.0.0.0", "--port", "8888;"]

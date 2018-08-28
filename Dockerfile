FROM frolvlad/alpine-glibc:alpine-3.8

RUN apk update && apk add libaio

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*



COPY ./instantclient_18_3.zip ./
RUN unzip instantclient_18_3.zip && \
    mv instantclient_18_3/ /usr/lib/ && \
    rm instantclient_18_3.zip && \
    mkdir /usr/lib/instantclient_18_3/wallet_NODEAPPDB2
COPY ./wallet_NODEAPPDB2 /usr/lib/instantclient_18_3/wallet_NODEAPPDB2
  
ENV ORACLE_BASE /usr/lib/instant_client_18_3
ENV LD_LIBRARY_PATH /usr/lib/instant_client_18_3
ENV TNS_ADMIN /usr/lib/instant_client_18_3/wallet_NODEAPPDB2
ENV ORACLE_HOME /usr/lib/instant_client_18_3
ENV PATH /usr/lib/instantclient_18_3:$PATH

RUN apk add --update nodejs nodejs-npm && \
      cd /usr/lib && \
      npm install oracledb
FROM node:lts-buster

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      ffmpeg \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

COPY ./package.json /usr/src/app/
WORKDIR /usr/src/app/
RUN npm install package.json

COPY . /usr/src/app/
RUN npm install
RUN npm build

ENTRYPOINT [ "node", "cast.js" ]

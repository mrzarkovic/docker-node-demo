FROM node:latest

RUN useradd --user-group --create-home --shell /bin/false app

ENV HOME=/home/app

COPY package.json $HOME/backend/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/backend

RUN npm install hapi --save
RUN npm install

USER root
RUN npm install nodemon -g
COPY . $HOME/backend
RUN chown -R app:app $HOME/*
USER app

CMD ["nodemon", "index.js"]
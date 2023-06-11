FROM node:16

COPY . /app

RUN npm install
RUN npm run build

WORKDIR /app

CMD [ "node", "./dist/server.js" ]

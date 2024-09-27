
FROM node:14-alpine as base

RUN apk add --no-cache bash

WORKDIR /src


COPY package*.json ./


RUN npm install --production


RUN chown -R node:node /src/node_modules


COPY . .


EXPOSE 3000


FROM base as dev
ENV NODE_ENV=development

RUN apk add --no-cache bash

RUN npm install -g nodemon

RUN chown -R node:node /src


USER node


CMD ["nodemon", "start.js"]


FROM base as production
ENV NODE_ENV=production

USER node


CMD ["npm", "start"]

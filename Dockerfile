FROM node:18-alpine as base

WORKDIR /src
COPY package.json .
COPY yarn.lock .

FROM base as production
COPY tsconfig.json .
RUN yarn install
COPY . .
RUN yarn run build
EXPOSE 3000
CMD ["yarn", "start"]

FROM base as dev
RUN yarn install
COPY . .
CMD ["yarn", "dev"]
FROM node:lts AS BUILD_IMAGE

WORKDIR /app

COPY . /app

RUN yarn install --registry https://registry.npmmirror.com/ && yarn run build

FROM zenika/alpine-chrome:124-with-node

COPY --from=BUILD_IMAGE /app/package.json /app/package.json
COPY --from=BUILD_IMAGE /app/api /app/api
COPY --from=BUILD_IMAGE /app/node_modules /app/node_modules

WORKDIR /app

USER root

EXPOSE 8000

CMD ["npm", "start"]
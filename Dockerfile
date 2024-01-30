FROM node:alpine as build-stage

WORKDIR /app

COPY package*.json .
RUN npm ci

COPY . .

RUN npm run build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=build-stage /app/dist .

RUN ls -l

RUN cat index.html
RUN cat main.js

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]




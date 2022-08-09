FROM node:16 as base

WORKDIR /usr/src/app
COPY package.json .
#RUN npm install -g npm-check-updates
#RUN ncu -u
RUN npm install
COPY . .
RUN npm run export

#FROM base as production
#ENV NODE_PATH=./build
#RUN npm run build
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=base /usr/src/app/_static .
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"] 
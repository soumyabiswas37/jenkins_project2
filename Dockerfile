FROM node

WORKDIR /project

RUN npm install express

RUN mkdir /public

COPY server.js /project

COPY index.html /public

EXPOSE 3000

CMD ["node","server.js"]

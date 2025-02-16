FROM node

WORKDIR /project

RUN npm install express

RUN mkdir /public

RUN cp server.js /project

RUN cp index.html /public

EXPOSE 3000

CMD ["node","server.js"]

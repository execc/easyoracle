FROM node:12

WORKDIR /wrk
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3002
CMD [ "node", "index.js" ]
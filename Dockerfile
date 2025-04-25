FROM node:18

WORKDIR /app

COPY code/config.js code/fetchRates.js code/redisClient.js package.json ./
RUN npm install

COPY . .

CMD ["node", "app.js"]

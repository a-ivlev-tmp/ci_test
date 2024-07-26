FROM node:20.16.0-alpine3.20 as builder
WORKDIR /usr/src/app
ADD package*.json ./
RUN npm ci
ADD . .
RUN npm run build --prod

FROM node:20.16.0-alpine3.20
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dist ./dist
ADD package*.json ./
RUN npm ci --omit=dev
CMD ["node", "./dist/main.js"]
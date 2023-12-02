# FROM node:16-alpine AS builder

# USER node

# RUN mkdir -p /home/node/app
# WORKDIR /home/node/app

# COPY --chown=node:node ./package.json ./
# RUN npm install
# COPY --chown=node:node ./ ./

# RUN npm run build

# FROM nginx
# COPY --from=builder /home/node/app/build /home/node/usr/share/nginx/html

FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
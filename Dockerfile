FROM node:lts-alpine as builder
WORKDIR /app
ADD ./package.json ./yarn.lock /app/
RUN yarn install --no-cache --frozen-lockfile
COPY . /app
RUN yarn build:frontend

FROM nginx:stable-alpine
COPY --from=builder /app/packages/frontend/build /usr/share/nginx/html
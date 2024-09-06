FROM node:18-alpine as build

WORKDIR /calcom

RUN set -eux;

ENV NODE_ENV="production"
ENV NODE_OPTIONS="--max-old-space-size=8192"
ENV PORT=3001

COPY ./calcom .

RUN yarn install
RUN yarn workspace @calcom/api-v2 run generate-schemas
RUN yarn workspace @calcom/api-v2 run build

EXPOSE 3001

CMD [ "yarn", "workspace", "@calcom/api-v2", "start:prod"]

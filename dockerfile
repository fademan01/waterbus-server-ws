FROM node:bookworm-slim as build

WORKDIR /usr/src/app

COPY --chown=node:node package.json ./
# COPY --chown=node:node yarn.lock ./

RUN yarn install
# --frozen-lockfile --network-timeout 100000

COPY --chown=node:node . .

# RUN yarn build

FROM node:bookworm-slim as development

WORKDIR /usr/src/app

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
# COPY --chown=node:node --from=build /usr/src/app/dist ./dist

ENV NODE_ENV=development

CMD [ "node", "--version" ]

FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json /app

RUN npm install

COPY . .

RUN npm run build

# ---- Runtime Stage ----

FROM node:22-slim

WORKDIR /app

COPY --from=builder /app/dist .

RUN npm install --only=production

CMD ["node", "index.js"]
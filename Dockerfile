# Stage 1: Build the Angular app with SSR using pnpm
FROM node:20 as build

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

COPY pnpm-lock.yaml ./
COPY package.json ./

RUN pnpm install

COPY . .

RUN pnpm run build

# Stage 2: Serve with Node.js (SSR)
FROM node:20

WORKDIR /app

COPY --from=build /app/dist/flight-booking-frontend /app/dist

EXPOSE 4000

CMD ["node", "dist/flight-booking-frontend/server/server.mjs"]

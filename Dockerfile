FROM oven/bun:1.2 AS base
WORKDIR /app

# Prisma binaries expect OpenSSL in this image
RUN apt-get update -qq && apt-get install -qq -y openssl ca-certificates && rm -rf /var/lib/apt/lists/*

COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile

COPY . .

# Default: game world. Override command for login/logger/friend.
CMD ["bun", "run", "src/app.ts"]

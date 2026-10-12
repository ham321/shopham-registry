FROM node:22-alpine
RUN apk add --no-cache openssl

EXPOSE 3000

WORKDIR /app

ENV NODE_ENV=production

COPY package.json package-lock.json* ./

RUN npm ci --omit=dev && npm cache clean --force

COPY . .

RUN npm run build

CMD ["sh", "-c", "echo '--- ENV NAMES ---'; env | cut -d= -f1 | sort; echo '--- END ---'; npm run docker-start"]
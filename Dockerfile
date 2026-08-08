FROM node:20-alpine AS builder

WORKDIR /app/backend

COPY backend/package*.json ./
COPY backend/prisma ./prisma/

RUN npm install

COPY backend/ ./

RUN npx prisma generate
RUN npm run build

FROM node:20-alpine AS runner

WORKDIR /app/backend

COPY backend/package*.json ./
COPY --from=builder /app/backend/node_modules ./node_modules
COPY --from=builder /app/backend/dist ./dist
COPY --from=builder /app/backend/prisma ./prisma

EXPOSE 5000

ENV PORT=5000
ENV NODE_ENV=production
ENV JWT_SECRET=nexora_erp_production_secret_key_2026
ENV DATABASE_URL="file:./dev.db"
ENV FRONTEND_URL="http://localhost:5173"

CMD ["sh", "-c", "npx prisma db push && npm run seed && node dist/server.js"]

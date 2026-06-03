# ---------- Build Stage ----------
    FROM node:20-alpine AS build

    WORKDIR /app
    
    COPY package*.json ./
    
    RUN npm install --legacy-peer-deps
    
    COPY . .
    
    RUN npm run build
    
    
    # ---------- Production Stage ----------
    FROM node:20-alpine
    
    WORKDIR /app
    
    COPY package*.json ./
    
    RUN npm install --only=production --legacy-peer-deps
    
    COPY --from=build /app .
    
    ENV HOST=0.0.0.0
    
    EXPOSE 3000
    
    CMD ["npm", "start"]
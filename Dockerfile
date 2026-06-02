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
    
    COPY --from=build /app ./
    
    EXPOSE 3000
    
    CMD ["sh", "-c", "HOST=0.0.0.0 npm start"]
    
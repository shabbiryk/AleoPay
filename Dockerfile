FROM node:16-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json files
COPY package*.json ./
COPY client/package*.json ./client/
COPY server/package*.json ./server/

# Install dependencies
RUN npm run install:all

# Copy the rest of the application
COPY . .

# Build the client
WORKDIR /app/client
RUN npm run build

# Production stage
FROM node:16-alpine

WORKDIR /app

# Copy built client, server, and root package.json
COPY --from=build /app/package*.json ./
COPY --from=build /app/client/build ./client/build
COPY --from=build /app/server ./server

# Install production dependencies
RUN npm install --only=production && \
    cd server && npm install --only=production

# Set environment variables
ENV NODE_ENV=production

# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "server/index.js"] 
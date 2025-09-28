# Build stage
FROM node:24-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Install build dependencies
RUN npm install --save-dev typescript

# Copy source code
COPY tsconfig.json tsconfig.build.json ./
COPY src/ ./src/

# Build the application
RUN npm run build


# Production stage
FROM node:24-alpine AS production

# Create app user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production && \
    npm install iobroker.js-controller --ignore-scripts && \
    npm cache clean --force

# Copy built application
COPY --from=builder /app/build ./build

# Change ownership to app user
RUN chown -R nodejs:nodejs /app
USER nodejs

COPY entrypoint.sh /

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]
FROM docker.io/library/ubuntu:24.04

# Prevent interactive prompts during apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies (Node.js, npm, Nginx, git, curl)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nginx \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone the OVH Game Panel repository
RUN git clone https://github.com/ovh/game-panel.git .

# Build Backend
WORKDIR /app/backend
RUN npm ci
RUN npm run build
RUN npm prune --omit=dev

# Build Frontend
WORKDIR /app/frontend
ARG VITE_DB_API_BASE_URL="https://db.gamepanel.ovh/"
ENV VITE_DB_API_BASE_URL=${VITE_DB_API_BASE_URL}
RUN npm ci
RUN npm run build

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy and setup entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

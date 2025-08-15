# Dockerfile for testing the workshop locally
FROM nginx:alpine

# Install git, python, bash and other tools participants will need
RUN apk add --no-cache \
    git \
    python3 \
    py3-pip \
    py3-yaml \
    bash \
    curl \
    nodejs \
    npm \
    make

# Copy workshop content
COPY . /usr/share/nginx/html/

# Copy nginx config for better SPA support
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

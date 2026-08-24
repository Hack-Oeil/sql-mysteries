FROM nginx:1.27-alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy application files from .docker/app
COPY .docker/app/ /usr/share/nginx/html/

# Copy nginx configuration
COPY .docker/webserver/default.conf /etc/nginx/conf.d/default.conf

# Copy entrypoint script
COPY .docker/webserver/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose HTTP port
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

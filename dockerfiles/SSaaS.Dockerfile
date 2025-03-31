# Use official lightweight NGINX base image
FROM nginx:alpine

# Remove default config if not needed
RUN rm -rf /usr/share/nginx/html/*

# Copy static site to default NGINX web root
COPY html/ /usr/share/nginx/html/

# Optional: Add your own NGINX config if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# CMD inherited from base image
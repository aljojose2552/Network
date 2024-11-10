# Use the Nginx base image
FROM nginx:alpine

# Copy index.html to the default Nginx public directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to access the container
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]


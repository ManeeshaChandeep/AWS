# Step 1: Build the React app
FROM node:16-alpine as build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all source files
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the built app using a lightweight server
FROM nginx:stable-alpine

# Copy the build output from the build step to the Nginx web server directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

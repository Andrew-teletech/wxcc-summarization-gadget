# Step 1: Build the Vue.js app
FROM node:18-alpine AS build-stage

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vue.js application
RUN npm run build

# Step 2: Serve the built app with NGINX
FROM nginx:alpine AS production-stage

# Copy the built app from the previous step
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Optional: Copy custom NGINX config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port NGINX will serve the app on
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]

# Use an official Node.js runtime as a parent image
FROM node:14-alpine as base

# Set the working directory
WORKDIR /src

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies (use npm ci for a clean install if you have a package-lock.json)
RUN npm install --production

# Change ownership of the node_modules directory
RUN chown -R node:node /src/node_modules

# Copy the rest of the application code
COPY . .

# Expose the port
EXPOSE 3000

# Development environment
FROM base as dev
ENV NODE_ENV=development

# Install nodemon for development
RUN npm install -g nodemon
# Change ownership of application code for non-root user
RUN chown -R node:node /src

# Switch to a non-root user
USER node

# Start the application with nodemon
CMD ["nodemon", "server.js"]

# Production environment
FROM base as production
ENV NODE_ENV=production

# Switch to a non-root user
USER node

# Start the application
CMD ["npm", "start"]

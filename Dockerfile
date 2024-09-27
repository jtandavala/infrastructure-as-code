FROM node:14-alpine as base

# Set the working directory
WORKDIR /src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install  # Change to npm ci if you have a package-lock.json and want a clean install

# Copy the rest of the application code
COPY . .

# Expose the port
EXPOSE 3000

# Development environment
FROM base as dev
ENV NODE_ENV=development
RUN npm install -g nodemon  # Install nodemon for development
CMD [ "nodemon", "server.js" ]

# Production environment
FROM base as production
ENV NODE_ENV=production
CMD ["npm", "start"]

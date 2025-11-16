# Use Node.js LTS
FROM node:20

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy source code
COPY app.js .

# Expose port
EXPOSE 3000

# Start app
CMD ["npm", "start"]

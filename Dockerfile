# base image
FROM node:7.8.0

# Set the working dir when our container executes
WORKDIR /app

# Copy our package.json file
ADD /source/package.json /app

RUN rm -rf node_modules
RUN npm install

# If you are building your code for production
# RUN npm install --only=production

COPY . /app

EXPOSE 3000

CMD [ "npm", "start" ]
#---------------------------------------------------------------------
# Build Phase - Final code for release to Production
#---------------------------------------------------------------------

# Baseline image
FROM node:alpine AS frontendbuild

# Set working directory
WORKDIR '/app/frontend'

#copy the pahcage definition file
COPY package.json ./.

# install npm
RUN npm install

# For Production, Copy all the files as they will not longer change
COPY . .

# execute BUILD command
RUN npm run build

# all build files would be in folder /app/frontend/build

#---------------------------------------------------------------------
# Production Phase
#---------------------------------------------------------------------

# Use Production HTTP Server as reference - serves static HTML files
# https://hub.docker.com/_/nginx

FROM nginx

# copy files from build phase to target folder in the NGINX docker
COPY --from=frontendbuild /app/frontend/build /usr/share/nginx/html 

# No need to specify RUN command, NGINX gets started by default



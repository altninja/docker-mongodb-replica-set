#
# MongoDB Dockerfile
#
# https://github.com/dockerfile/mongodb
#

# Pull base image.
FROM ubuntu:latest

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse' > /etc/apt/sources.list.d/mongodb-org-3.0.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /

# Expose ports for each Mongo replica set instance
EXPOSE 27017
EXPOSE 27018
EXPOSE 27019

# Copy required files over to container
COPY conf/ /conf/
COPY start.sh /start.sh

# Run start shell when container launches
CMD ["sh", "start.sh"]

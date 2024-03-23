FROM debian:latest

# Install deps
RUN apt-get update
RUN apt-get install -y wget gnupg2 lsb-release
RUN sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get -y install postgresql
RUN apt-get install -y build-essential cmake libpq-dev libssl-dev postgresql postgresql-server-dev-16


# Copy source files
RUN mkdir -p /root/src
COPY . /root/src/

# Build
WORKDIR /root/src
RUN cmake -DCMAKE_INSTALL_PREFIX=$HOME/pgquarrel -DCMAKE_PREFIX_PATH=/usr/lib/postgresql/16 .
RUN make
RUN make install
RUN mv /root/pgquarrel/bin/pgquarrel /usr/bin/pgquarrel

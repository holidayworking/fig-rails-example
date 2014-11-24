FROM ruby:2.1.5

RUN apt-get update && apt-get install -y locales --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN echo "Asia/Tokyo" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle install -j4

RUN mkdir /app
WORKDIR /app
ADD . /app

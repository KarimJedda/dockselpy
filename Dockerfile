FROM ubuntu:trusty

# Necassary dependencies
RUN apt-get update \
    && apt-get install -y \
               python3 \
               python3-pip \
               libgconf2-4 \
               libnss3-1d \
               libxss1 \
               fonts-liberation \
               libappindicator1 \
               xdg-utils \
               software-properties-common \
               curl \
               unzip \
               wget \
               xvfb \
    && apt-get clean


# install geckodriver and firefox
RUN GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/geckodriver

RUN add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa \
    && apt-get update -y \
    && apt-get install -y firefox


# install chromedriver and google-chrome
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
    && wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

RUN unzip chromedriver_linux64.zip -d /usr/bin \
    && chmod +x /usr/bin/chromedriver \
    && dpkg -i google-chrome*.deb \
    && apt-get install -y -f

# Copy requirements
COPY requirements.txt /code/
WORKDIR /code

# Install necessary libraries
RUN pip3 install -r requirements.txt


ENV APP_HOME /code
ADD . /code

CMD tail -f /dev/null
# CMD python3 example.py

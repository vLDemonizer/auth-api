FROM ubuntu:16.04

RUN apt-get update --fix-missing && \
    apt-get install -y \
        git \
        curl \
        python-pip \
        python-psycopg2 \
        python-software-properties \
        supervisor \
        vim

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install nodejs

RUN npm install -g --save-dev babel-cli

RUN service supervisor stop

ADD /docker/app/supervisor.conf /etc/supervisor/conf.d/auth-api.conf

ADD ./requirements.txt /root/requirements.txt

RUN pip install -r /root/requirements.txt

ADD . /root/auth-api/

WORKDIR /root/auth-api/


ADD /docker/app/start.sh /root/start.sh

RUN chmod 700 /root/start.sh

EXPOSE 80

CMD ["/root/start.sh"]  
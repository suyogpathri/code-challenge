ARG ALPINE_VERSION=3.15
FROM alpine:${ALPINE_VERSION}

ENV PYTHONUNBUFFERED 1

RUN apk -v --no-cache --update add \
        python3 \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget

RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN mkdir /opt/app
WORKDIR /opt/app

COPY /api/requirements.txt /opt/app

RUN pip install -r requirements.txt

COPY /api/. /opt/app

EXPOSE 80

CMD ["python3", "app.py"]

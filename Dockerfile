FROM tensorflow/tensorflow:latest-py3

RUN apt-get update && apt-get install -yq git && rm -rf /var/lib/apt/lists/*

WORKDIR /root/
RUN git clone https://github.com/Tofull/image-classifier-service.git

ADD https://github.com/alexellis/faas/releases/download/0.6.5/fwatchdog /usr/bin
RUN chmod +x /usr/bin/fwatchdog

WORKDIR /root/

COPY index.py .
COPY downloader.py .
COPY requirements.txt .
RUN pip install -r requirements.txt

ENV fprocess="python index.py"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]

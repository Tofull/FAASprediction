FROM tensorflow/tensorflow

RUN git clone https://github.com/Tofull/image-classifier-service.git

ADD https://github.com/alexellis/faas/releases/download/0.6.5/fwatchdog /usr/bin
RUN chmod +x /usr/bin/fwatchdog

WORKDIR /root/

COPY handler.py .
COPY downloader.py .
COPY requirements.txt .
RUN pip install -r requirements.txt

ENV fprocess="python handler.py"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]

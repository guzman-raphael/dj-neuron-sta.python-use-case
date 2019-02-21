FROM python:3.7.2-alpine3.9

# datajoint + UI support
RUN \
  apk update && \
  apk --no-cache --update-cache add --virtual build-min-dependencies \
    musl-dev && \
  apk --no-cache --update-cache add --virtual build-erd-dependencies \
    g++ pkgconfig && \
  apk --no-cache --update-cache add --virtual run-erd-dependencies \
    gcc freetype-dev graphviz ghostscript-fonts && \
  pip3 install matplotlib datajoint && \
  pip3 install -i https://test.pypi.org/simple/ dj-neuron-rguzman && \
  apk del build-min-dependencies build-erd-dependencies

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["src/run.py"]

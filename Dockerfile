FROM ubuntu:jammy-20250819

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONIOENCODING=utf-8

RUN apt-get update -y && \
    apt-get install curl python3 python3-pip python3-setuptools python3-wheel python3-six python3-dateutil python3-bcrypt python3-passlib -y --no-install-recommends && \
    pip3 install radicale[bcrypt] && \
    apt-get purge -y python3-pip python3-wheel python3-setuptools && \
    apt-get autoremove -y --purge && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --disabled-password --gecos '' --shell /bin/false --uid 1000 radicale

COPY config /etc/radicale/config

EXPOSE 5232/tcp
VOLUME /data

HEALTHCHECK --interval=60s --timeout=10s --start-period=5s CMD curl --fail http://localhost:5232/.web || exit 1

USER radicale

ENTRYPOINT ["python3", "-u", "-m", "radicale"]

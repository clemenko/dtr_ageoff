FROM alpine
LABEL maintainer="clemenko@docker.com", \
      org.label-schema.vcs-url="https://github.com/clemenko/dtr_ageoff"
RUN apk -U upgrade && apk add --no-cache curl jq coreutils ncurses bash && \
    rm -rf /var/cache/apk/*
WORKDIR /code
ADD dtr_ageoff.sh /code
CMD ["bash", "/code/dtr_ageoff.sh"]
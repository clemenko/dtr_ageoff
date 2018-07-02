FROM alpine
LABEL maintainer="clemenko@docker.com", \
      org.label-schema.vcs-url="https://github.com/clemenko/dtr_ageoff"
RUN apk -U upgrade && \
    apk -U add --no-cache coreutils && \
    rm -rf /var/cache/apk/*

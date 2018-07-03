FROM alpine:latest

RUN apk --no-cache add bash curl coreutils jq ncurses

COPY dtr_ageoff.sh /

CMD ["/dtr_ageoff.sh"]

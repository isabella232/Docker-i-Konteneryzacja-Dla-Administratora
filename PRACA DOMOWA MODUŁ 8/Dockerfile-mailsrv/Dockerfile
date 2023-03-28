FROM ubuntu

RUN apt update && apt upgrade -y && apt install -y \
postfix \
postfix-mysql \
dovecot-core \
dovecot-imapd \
dovecot-pop3d \
dovecot-lmtpd \
dovecot-mysql

COPY ./postfix/ /etc/postfix/
COPY ./dovecot/ /etc/dovecot/
COPY ./conf.d/ /etc/dovecot/conf.d/

RUN chmod -R o-rwx /etc/postfix

RUN mkdir /var/mail/workhome.augustow.pl
RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /var/mail
RUN chown -R vmail:vmail /var/mail

EXPOSE 25/tcp
EXPOSE 465/tcp
EXPOSE 587/tcp
EXPOSE 110/tcp
EXPOSE 143/tcp
EXPOSE 993/tcp
EXPOSE 995/tcp

ENTRYPOINT ["tail", "-f", "/dev/null"]

CMD ["postfix start"]
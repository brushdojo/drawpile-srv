# pull an official drawpile-srv image from dockerhub
FROM callaa/drawpile-srv:2.1.12

# set environment variables with default values
ENV CONFIG_DATABASE_FILEPATH=/home/drawpile/config.db
ENV WEB_ADMIN_CREDENTIALS_FILE=/run/secrets/web-admin-credentials

# temporarily set the user to root for the build process
USER root

# install sqlite and bash for database initialization and maintenance
RUN apk add bash sqlite

# create all the directories required by this image
RUN mkdir \
  /docker-entrypoint \
  /home/drawpile/sessions \
  /home/drawpile/templates

# copy all session templates to the drawpile templates directory
COPY session-templates /home/drawpile/templates

# give the drawpile user ownership of the drawpile directory
RUN chown -R drawpile /home/drawpile

# copy all database scripts to the entrypoint directory
COPY database-scripts /docker-entrypoint

# copy the entrypoint to the image root
COPY docker-entrypoint.sh /

# give execution permissions to the entrypoint
RUN chmod +x /docker-entrypoint.sh

# set the default entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# expose the drawpile-srv port and the web admin api port
EXPOSE 27750 27780

# set the default command
CMD [ \
  "bash", "-c", \
  "drawpile-srv \
  --local-host brushdojo.com \
  --database $CONFIG_DATABASE_FILEPATH \
  --templates /home/drawpile/templates \
  --sessions /home/drawpile/sessions \
  --port 27750 \
  --web-admin-port 27780 \
  --web-admin-access all \
  --web-admin-auth $(< $WEB_ADMIN_CREDENTIALS_FILE)" \
  ]

# set the runtime user to drawpile
USER drawpile

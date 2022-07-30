FROM alpine
RUN apk add openjdk8 wget unzip

ARG LT_VERSION="5.8"
ARG LT_USER="languagetool"

# Install languagetool
WORKDIR /opt
RUN wget -q https://languagetool.org/download/LanguageTool-stable.zip -O /opt/languagetool.zip
RUN unzip -q languagetool.zip
RUN rm -rf /opt/languagetool.zip
RUN adduser --disabled-password $LT_USER
RUN chown -R $LT_USER:$LT_USER /opt/LanguageTool-$LT_VERSION


# Start languagetool
EXPOSE 8081
WORKDIR /opt/LanguageTool-$LT_VERSION
USER $LT_USER
RUN echo "Starting LanguageTool $LT_VERSION as $LT_USER user."
CMD java -cp languagetool-server.jar org.languagetool.server.HTTPServer --public --port 8081 --allow-origin

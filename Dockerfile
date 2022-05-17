FROM sonarsource/sonar-scanner-cli:4

LABEL "com.github.actions.name"="SonarQube Scan"
LABEL "com.github.actions.description"="Scan your code with SonarQube Scanner to detect bugs, vulnerabilities and code smells in more than 25 programming languages."
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="green"

LABEL version="1.0.3"
LABEL repository="https://github.com/anand-kirori-bain/node-js-template"
LABEL homepage="https://bain.github.io"
LABEL maintainer="anand-kirori-bain"

RUN npm config set unsafe-perm true && \
  npm install --silent --save-dev -g typescript@3.5.2 && \
  npm config set unsafe-perm false && \
  apk add --no-cache ca-certificates jq

ENV NODE_PATH "/usr/lib/node_modules/"

COPY entrypoint.sh /entrypoint.sh

COPY sonarqube.cer /opt/sonarqube.cer

RUN keytool -import -trustcacerts -keystore cacerts -storepass changeit -noprompt -alias sonarqube -file /opt/sonarqube.cer

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

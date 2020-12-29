FROM amazon/aws-cli:latest

LABEL "com.github.actions.name"="deploy-s3-action"
LABEL "com.github.actions.description"="Github action for deploy a folder (recursively) to an Amazon S3 bucket. "
LABEL "com.github.actions.icon"="archive"
LABEL "com.github.actions.color"="orange"

LABEL "maintainer"="Danilo Velasquez <danilo.velasquez@gmail.com.com>"
LABEL "repository"="https://github.com/dvelasquez/deploy-s3-action"
LABEL version="1.0.0"

ADD entrypoint.sh /entrypoint.sh

#Make entrypoint file executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

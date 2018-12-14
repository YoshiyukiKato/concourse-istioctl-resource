FROM yoshiyuki/istioctl

RUN apk add --update --upgrade --no-cache jq
ADD assets /opt/resource
RUN chmod +x /opt/resource/*

ENTRYPOINT [ "/bin/bash"]

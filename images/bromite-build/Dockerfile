ARG BROMITE_SHA

FROM uazo/bromite:$BROMITE_SHA

USER lg
WORKDIR /home/lg/working_dir

COPY pre-start.sh .
COPY start-build.sh .
COPY goma_auth.py .
COPY casupload .
COPY build_args.gni .

RUN sudo chmod +x ./start-build.sh \
    && \
    sudo chmod +x ./pre-start.sh \
    && \
    sudo chmod 775 ./goma_auth.py


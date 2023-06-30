FROM moddevices/mod-plugin-builder AS build
COPY . /tmp/moddevices/alo
RUN cp -r /tmp/moddevices/alo /home/builder/mod-plugin-builder/plugins/package
RUN ./build alo

FROM scratch
COPY --from=build /home/builder/mod-workdir/plugins/alo.lv2 /alo.lv2

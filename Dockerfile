FROM debian:8.11-slim

RUN adduser --disabled-password --gecos sonarr sonarr

ENV MONO_VERSION 5.14.0.177

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xFDA5DFFC
RUN echo "deb http://download.mono-project.com/repo/debian stable-jessie/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official-stable.list
RUN echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list
RUN apt-get update \
  && apt-get install -y libmono-cil-dev nzbdrone \
  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN mkdir -p /sonarr-data && chown sonarr:sonarr /sonarr-data

WORKDIR /sonarr-data
USER sonarr

CMD mono --debug /opt/NzbDrone/NzbDrone.exe /data=/sonarr-data





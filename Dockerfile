FROM elicocorp/odoo:7.0
MAINTAINER Elico-Corp <contact@elico-corp.com>

# CN fonts
RUN apt-get update && \
  apt-get -y install ttf-wqy-zenhei

# Ubuntu CN mirror
# 2 reasons to set the mirror after apt-get update:
#  1) Docker Hub takes more than 15 minutes to fetch the packages list since the mirror server is in China
#  2) apt repository format is subject to race conditions when a mirror is updated (http://askubuntu.com/a/160179)
RUN sed -i 's/archive\.ubuntu\.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# pip CN mirror
RUN mkdir -p ~/pip && \
  echo "[global]" > ~/pip/pip.conf && \
  echo "index-url = https://pypi.mirrors.ustc.edu.cn/simple" >> ~/pip/pip.conf

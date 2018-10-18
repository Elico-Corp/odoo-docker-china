FROM elicocorp/odoo
MAINTAINER Elico Corp <webmaster@elico-corp.com>

# Set OS timezone to China
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Set Odoo timezone to China (will be set at startup thanks to Odoo
# parameter substitution)
ENV ODOO_TIMEZONE=Asia/Shanghai

# CN fonts
RUN apt-get update && \
  apt-get -y install ttf-wqy-zenhei

# Ubuntu CN mirror
# 2 reasons to set the mirror after apt-get update:
#  1) Docker Hub takes more than 15 minutes to fetch the packages list since
#     the mirror server is in China
#  2) apt repository format is subject to race conditions when a mirror is
#     updated (http://askubuntu.com/a/160179)
RUN sed -i 's/archive\.ubuntu\.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# pip CN mirror
RUN mkdir -p ~/pip && \
  echo "[global]" > ~/pip/pip.conf && \
  echo "index-url = http://mirrors.aliyun.com/pypi/simple" >> ~/pip/pip.conf

# Google links CN mirror
RUN sed -i "s/fonts\.googleapis\.com/fonts.lug.ustc.edu.cn/g" \
  `grep 'fonts\.googleapis\.com' -rl /opt/odoo/sources/odoo/addons`

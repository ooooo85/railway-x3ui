FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tehran

# Update and install essentials
RUN apt-get update && apt-get install -y \
    curl wget git vim nano htop \
    nodejs npm \
    python3 python3-pip \
    php php-cli php-curl php-mbstring php-mysql \
    mysql-client \
    nginx \
    build-essential \
    unzip zip \
    sudo \
    tzdata \
    ttyd \
    && apt-get clean

# Install latest Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install useful global npm packages
RUN npm install -g pm2 serve

# Set root password
RUN echo 'root:root123' | chpasswd

# Create working directory
WORKDIR /root/workspace

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]

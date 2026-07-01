FROM php:8.5.1-apache

# Actualizar e instalar extensiones de PHP para MySQL/MariaDB
RUN apt-get update && apt-get install -y \
    libmariadb-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Habilitar el módulo rewrite de Apache (común en apps PHP)
RUN a2enmod rewrite

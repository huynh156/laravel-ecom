# Sử dụng image PHP với Apache
FROM php:8.1-apache

# Cài đặt các package cần thiết
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Cài đặt Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Thiết lập thư mục làm việc
WORKDIR /var/www/html

# Sao chép mã nguồn Laravel
COPY . .

# Thiết lập quyền cho các thư mục cần thiết
RUN chown -R www-data:www-data /var/www/html/ 
# Expose cổng mà ứng dụng chạy
EXPOSE 80
EXPOSE 8000

# Thiết lập lệnh khởi động container
CMD ["apache2-foreground"]

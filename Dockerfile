FROM nginx:alpine

# Копируем все статические файлы
COPY static/ /usr/share/nginx/html/static/
COPY index.html /usr/share/nginx/html/

# Копируем конфигурацию Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Устанавливаем правильные права
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

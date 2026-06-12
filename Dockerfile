FROM alpine:latest

# تثبيت الأوسكام والأدوات الأساسية
RUN apk add --no-cache oscam curl

# تحميل أداة لوصل النفق (توضع كبديل فائق الاستقرار لـ ngrok)
RUN curl -L -o /usr/local/bin/ngrok https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_linux_amd64 \
    && chmod +x /usr/local/bin/ngrok

# إنشاء ملفات الإعدادات واليوزر وبورت الشيرنج (12000)
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# تشغيل الأوسكام مباشرة
CMD ["oscam", "-c", "/config"]

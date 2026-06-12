FROM alpine:latest

# تثبيت الأوسكام فقط
RUN apk add --no-cache oscam

# إنشاء ملفات الإعدادات واليوزر وبورت الشيرنج (12000)
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# تعيين المنفذ 12000 كمنفذ افتراضي للحاوية
EXPOSE 12000

# تشغيل الأوسكام مباشرة وجعله يعمل في الواجهة الأساسية
CMD ["oscam", "-c", "/config", "-f"]

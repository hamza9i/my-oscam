FROM alpine:latest

# تثبيت الأوسكام والأدوات الأساسية للتحميل
RUN apk add --no-cache oscam curl

# تحميل نسخة ngrok المخصصة لنظام ألباين (musl) لضمان عدم التجمد
RUN curl -s https://bin.equinox.io/c/b3421690-6c53-424a-a400-da0037a34293/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin

# إنشاء ملفات الإعدادات واليوزر وبورت الشيرنج (12000)
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# أمر تشغيل السيرفرين معاً مع توجيه الـ Logs لرؤيتها في ريلواي
CMD oscam -c /config & ngrok tcp 12000 --authtoken 3F0fEUQm0clSsiKPRWxgl7NyLWg_5fJud6W2YWPXsfxFixhhi --log=stdout

FROM alpine:latest

# تثبيت الأوسكام، curl، وأداة فك ضغط الملفات zip
RUN apk add --no-cache oscam curl unzip

# تحميل نسخة ngrok الرسمية والمستقرة وفك ضغطها بدون أي مشاكل
RUN curl -s -o ngrok.zip https://bin.equinox.io/c/b3421690-6c53-424a-a400-da0037a34293/ngrok-v3-stable-linux-amd64.zip \
    && unzip ngrok.zip -d /usr/local/bin \
    && rm ngrok.zip

# إنشاء ملفات الإعدادات واليوزر وبورت الشيرنج (12000)
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# أمر تشغيل السيرفرين معاً مع توجيه البيانات
CMD oscam -c /config & ngrok tcp 12000 --authtoken 3F0fEUQm0clSsiKPRWxgl7NyLWg_5fJud6W2YWPXsfxFixhhi --log=stdout

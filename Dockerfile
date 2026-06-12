FROM ubuntu:22.04

# تثبيت الأدوات الأساسية والأوسكام
RUN apt-get update && apt-get install -y curl oscam

# تحميل وتثبيت ngrok الرسمي المتوافق مع السيرفر
RUN curl -s https://bin.equinox.io/c/b3421690-6c53-424a-a400-da0037a34293/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin

# إنشاء مجلد الإعدادات وملف التكوين للأوسكام والسيسكام
RUN mkdir -p /config && echo "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# أمر تشغيل الأوسكام وفتح نفق ngrok معاً في نفس الوقت بدون تجمد
CMD oscam -c /config & ngrok tcp 12000 --authtoken 3F0fEUQm0clSsiKPRWxgl7NyLWg_5fJud6W2YWPXsfxFixhhi

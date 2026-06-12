FROM alpine:latest

# تثبيت الأوسكام والأدوات الأساسية
RUN apk add --no-cache oscam curl

# تحميل أداة النفق السحابي المستقرة والمجانية لـ Alpine
RUN curl -L -o /usr/local/bin/localtonet https://github.com/localtonet/localtonet-client/releases/latest/download/localtonet-linux-musl-x64 \
    && chmod +x /usr/local/bin/localtonet

# إنشاء ملفات الإعدادات واليوزر وبورت الشيرنج (12000)
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# أمر تشغيل الأوسكام وربطه برقم النفق الخاص بك مباشرة
CMD oscam -c /config & localtonet tunnel start --id 2149085

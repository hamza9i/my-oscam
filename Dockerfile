FROM alpine:latest

# تثبيت الأوسكام وأداة الاتصال الآمن openssh
RUN apk add --no-cache oscam openssh-client

# إنشاء ملفات الإعدادات واليوزر وبورت الشيرنج (12000)
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user

# تشغيل الأوسكام وفتح نفق ثابت ومستقر عبر خدمة serveo العالمية
CMD oscam -c /config & ssh -v -N -T -o StrictHostKeyChecking=no -R 80:127.0.0.1:12000 serveo.net

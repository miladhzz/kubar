# استفاده از تصویر پایه Python
FROM python:3.11-slim

# تنظیم متغیرهای محیطی
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# تنظیم دایرکتوری کاری
WORKDIR /app

# نصب وابستگی‌های سیستم
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# کپی فایل requirements و نصب وابستگی‌ها
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# کپی کل پروژه
COPY . .

# جمع‌آوری فایل‌های استاتیک
RUN python manage.py collectstatic --noinput || true

# پورت پیش‌فرض
EXPOSE 80

# دستور اجرای سرور
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


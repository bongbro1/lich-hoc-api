# Sử dụng Python Slim image để tối ưu dung lượng
FROM python:3.11-slim

# Ngăn Python tạo file .pyc và cho phép log hiển thị ngay lập tức
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Thiết lập thư mục làm việc
WORKDIR /app

# Cài đặt các thư viện hệ thống cần thiết (nếu có dùng pandas/numpy)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements và cài đặt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ mã nguồn vào container
COPY . .

# Mở port cho Flask
EXPOSE $PORT

# Chạy ứng dụng bằng Gunicorn với biến PORT tự động của Render
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:${PORT:-5000} app:app --timeout 120"]
# Lịch Học API

Lịch Học API là một dịch vụ backend được xây dựng bằng **Flask (Python)**, cung cấp API để lấy thông tin sinh viên, thời khóa biểu (lịch học), và điểm số từ hệ thống tín chỉ của các trường đại học như **ICTU** (Đại học Công nghệ Thông tin và Truyền thông - Đại học Thái Nguyên) và **TNUT** (Đại học Kỹ thuật Công nghiệp - Đại học Thái Nguyên).

## 🚀 Công nghệ sử dụng

- **Ngôn ngữ & Framework**: Python, Flask
- **Scraping / Crawling**: BeautifulSoup4, Requests, HTTPX
- **Xử lý dữ liệu**: Pandas, OpenPyXL
- **Cơ sở dữ liệu**: JSON file (Lưu trữ trực tiếp tại `database/users.json`)
- **Deploy & Tích hợp**: Docker, Docker Compose, Gunicorn, Firebase Admin

## 📁 Cấu trúc thư mục chính

- `/config`: Các cấu hình của hệ thống.
- `/database`: Logic kết nối và xử lý với cơ sở dữ liệu.
- `/domains`: Chứa logic nghiệp vụ riêng lẻ cho từng trường (ICTU, TNUT...).
- `/models`: Khai báo các mô hình dữ liệu (Database Models).
- `app.py` / `main.py`: Các file chính khởi chạy ứng dụng và điều hướng logic.
- `manage.py`: Script quản lý ứng dụng (migration, v.v.).

## 🔌 Các tính năng & API Endpoints chính
- **Xác thực**:
  - `POST /login`: Đăng nhập trên nền tảng web.
  - `POST /app-login`: Đăng nhập và trả về dữ liệu cho mobile app.
- **Dữ liệu Sinh viên**:
  - `POST /schedule`: Lấy lịch học của sinh viên.
  - `POST /student_marks`: Lấy điểm số của sinh viên.
- **Tính năng mở rộng**:
  - `POST /api/ai/chat`: Tích hợp Trợ lý học tập AI (sử dụng Ollama) giải đáp thắc mắc và nhắc nhở lịch học.
  - `GET /agora/token`: Sinh token Agora cho tính năng gọi thoại/video.
- **Quản trị & Thông báo (Firebase Admin)**:
  - `GET /api/admin/users`: Lấy danh sách người dùng.
  - `POST /api/send-notification`: Gửi push notification qua FCM.
  - `POST /api/admin/system-notifications`: Gửi thông báo hệ thống nội bộ.

## ⚙️ Hướng dẫn cài đặt và chạy nội bộ (Local)

### 1. Yêu cầu hệ thống
- Python 3.8+
- Môi trường ảo (khuyến nghị dùng `venv` hoặc `conda`)

### 2. Cài đặt thư viện
Tạo môi trường ảo và cài đặt các thư viện cần thiết:
```bash
# Tạo môi trường ảo
python -m venv venv

# Kích hoạt môi trường (Windows)
venv\Scripts\activate
# Hoặc trên Linux/macOS
source venv/bin/activate

# Cài đặt dependencies
pip install -r requirements.txt
```

### 3. Cấu hình Cơ sở dữ liệu
Hệ thống sử dụng **File-based Database** (lưu trữ dưới dạng file JSON).
Dữ liệu người dùng sẽ được lưu tự động tại: `database/users.json`. Bạn không cần cài đặt thêm hệ quản trị cơ sở dữ liệu nào khác như PostgreSQL hay MySQL.

### 4. Chạy ứng dụng
Sau khi cài đặt xong, khởi chạy API server:
```bash
flask run
# Hoặc
python app.py
```

## 🐳 Khởi chạy bằng Docker
Nếu bạn không muốn cài đặt các dependencies ở máy tính cá nhân, bạn có thể chạy thông qua Docker:

```bash
docker-compose up --build -d
```
Hệ thống sẽ tự động build image và chạy các service tương ứng được định nghĩa trong file `docker-compose.yml`.

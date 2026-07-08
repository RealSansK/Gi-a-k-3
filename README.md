## Cấu trúc thư mục
```
src/main/java/controller/LoginServlet.java   - Xử lý đăng nhập
src/main/java/util/PasswordUtil.java         - Hàm băm mật khẩu SHA-256
src/main/webapp/index.jsp                    - Trang danh sách + kết nối DB
src/main/webapp/update.jsp                   - Sửa thông tin
src/main/webapp/delete.jsp                   - Xóa thông tin
setup_schooll.sql                            - Script tạo database mẫu
```

## Mô tả
Ứng dụng web quản lý học viên (CRUD), xây dựng bằng Java (Maven, JSP, Servlet), chạy trên Apache Tomcat, kết nối MySQL. Chức năng đăng nhập sử dụng mật khẩu băm SHA-256.

## Yêu cầu môi trường
- NetBeans IDE (có hỗ trợ Java EE / Jakarta EE)
- Apache Tomcat 9.0
- MySQL Server (đã cài riêng, không dùng XAMPP)
- JDK 11 trở lên

## Hướng dẫn cài đặt và chạy

### 1. Clone project
```bash
git clone https://github.com/RealSansK/Gi-a-k-3.git
```
Mở project bằng NetBeans (File > Open Project).

### 2. Tạo database
Mở MySQL Workbench (hoặc Command Line Client), đăng nhập bằng user `root`, chạy file `setup_schooll.sql` (đính kèm trong repo) để:
- Tạo database `schooll`
- Tạo bảng `users` (tài khoản đăng nhập, mật khẩu đã băm SHA-256)
- Tạo bảng `records` (dữ liệu học viên: id, name, course, fee)

### 3. Cấu hình kết nối MySQL
Mở file `src/main/webapp/index.jsp`, dòng khoảng 108, sửa lại **mật khẩu MySQL đúng với máy đang chạy**:
```java
con = DriverManager.getConnection("jdbc:mysql://localhost/schooll", "root", "MẬT_KHẨU_CỦA_BẠN");
```

### 4. Chạy project
- Trong NetBeans, chuột phải vào project > **Run** (hoặc Shift+F6)
- NetBeans sẽ tự deploy lên Tomcat và mở trình duyệt tại:
```
http://localhost:8090/mavenproject1/
```

### 5. Tài khoản đăng nhập mẫu
| Username | Password |
|----------|----------|
| admin    | 123456   |

## Chức năng chính
- Đăng nhập (xác thực bằng mật khẩu băm SHA-256)
- Xem danh sách học viên (`index.jsp`)
- Thêm / Sửa (`update.jsp`) / Xóa (`delete.jsp`) học viên

## Ghi chú
Nếu gặp lỗi `Access denied for user 'root'@'localhost'`, nguyên nhân là mật khẩu MySQL trong `index.jsp` chưa khớp với mật khẩu thật của máy đang chạy — cần sửa lại theo Bước 3.

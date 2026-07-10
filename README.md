## Cấu trúc thư mục
```
src/main/java/controller/LoginServlet.java   - Xử lý đăng nhập
src/main/java/util/PasswordUtil.java         - Hàm băm mật khẩu SHA-256
src/main/webapp/index.jsp                    - Trang danh sách + kết nối DB
src/main/webapp/update.jsp                   - Sửa thông tin
src/main/webapp/delete.jsp                   - Xóa thông tin
setup_schooll.sql                            - Script tạo database mẫu
```

## Yêu cầu môi trường
- NetBeans IDE (có hỗ trợ Java EE / Jakarta EE)
- Apache Tomcat 9.0
- MySQL Server (đã cài riêng, không dùng XAMPP)
- JDK 11 trở lên

## Hướng dẫn cài đặt và chạy

### 1. Mở project bằng NetBeans (File > Open Project).

### 2. Tạo database
Mở MySQL Workbench (hoặc Command Line Client), đăng nhập bằng user `root`, chạy file `setup_schooll.sql` (đính kèm trong repo) để:
- Tạo database `schooll`
- Tạo bảng `users` (tài khoản đăng nhập, mật khẩu đã băm SHA-256)
- Tạo bảng `records` (dữ liệu học viên: id, name, course, fee)

### 3. Cấu hình kết nối MySQL
Mở file `src/main/webapp/index.jsp` và `src/main/java/controller/LoginServlet.java`, dòng khoảng 108, sửa lại **mật khẩu MySQL đúng với máy đang chạy**:
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

## Xử lý sự cố (Troubleshooting)

### 1. Lỗi `Access denied for user 'root'@'localhost'` (HTTP 500)
Xảy ra khi mật khẩu MySQL trong code (`getConnection(...)`) không khớp với mật khẩu thật của máy đang chạy.
**Cách sửa:** Rà soát toàn bộ các file có gọi `DriverManager.getConnection(...)` — không chỉ `index.jsp`, mà cả `update.jsp`, `delete.jsp`, `insert.jsp`, `LoginServlet.java` — sửa đúng mật khẩu MySQL thật ở tất cả các file này.

### 2. Lỗi `Không tìm thấy cột 'strname'` (Unknown column)
Xảy ra khi tên cột trong database không khớp với tên cột code đang gọi (ví dụ code dùng `strname` nhưng database tạo cột `name`).
**Cách sửa:** Đảm bảo bảng `records` dùng đúng tên cột `strname` (không phải `name`) khi chạy script `setup_schooll.sql`, hoặc đổi lại bằng lệnh:
```sql
ALTER TABLE records CHANGE COLUMN name strname VARCHAR(100);
```

### 3. Lỗi HTTP 404 khi submit form đăng nhập (`/LoginServlet` không tìm thấy)
Nguyên nhân: dự án dùng **Tomcat 10+** (chuẩn Jakarta EE), nhưng code servlet lại import theo chuẩn cũ `javax.servlet.*` — khiến annotation `@WebServlet` không được Tomcat nhận diện, servlet không được đăng ký route.

**Lưu ý về phiên bản Tomcat:**
- **Tomcat 10 trở lên** → bắt buộc dùng `jakarta.servlet.*` (chuẩn Jakarta EE)
- **Tomcat 9 trở xuống** → dùng `javax.servlet.*` (chuẩn Java EE cũ)

Hai chuẩn này **không tương thích với nhau** — dùng sai chuẩn so với phiên bản Tomcat đang chạy sẽ khiến servlet không được đăng ký, gây lỗi 404 dù code không có lỗi cú pháp và build vẫn thành công.

**Cách kiểm tra Tomcat đang dùng phiên bản nào:** xem ở dòng cuối trang lỗi (ví dụ `Apache Tomcat/10.1.55` nghĩa là Tomcat 10).

**Cách sửa:** Trong `LoginServlet.java` (và các servlet khác nếu có), đổi toàn bộ:
```java
import javax.servlet.*
```
thành:
```java
import jakarta.servlet.*
```
Sau đó **Clean and Build** lại project rồi Run lại.

### 4. Sau khi sửa code nhưng lỗi vẫn còn
NetBeans có thể đang chạy bản deploy cũ trên Tomcat. Luôn **Clean and Build** trước, sau đó **Run** lại toàn bộ project để đảm bảo thay đổi được áp dụng.

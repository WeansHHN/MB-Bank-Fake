# Fake MB Notification App

Đây là một dự án ứng dụng iOS giả lập thông báo của ngân hàng MB, được phát triển với mục đích học tập và thử nghiệm. Ứng dụng này cho phép bạn tạo các thông báo giả về giao dịch ngân hàng.

## Yêu cầu

- Xcode 12.5 trở lên
- Swift 5.3 trở lên
- macOS 11.0 trở lên
- Command line tools: `xcodebuild`, `codesign`, `ldid`

## Cài đặt

1. Clone repository này về máy tính của bạn:

    ```bash
    git clone https://github.com/WeansHHN/MB-Bank-Fake.git
    cd MB-Bank-Fake
    ```

2. Mở dự án bằng Xcode:

    ```bash
    open MB-Bank-Fake.xcodeproj
    ```

3. Thực hiện các thiết lập cần thiết trong Xcode nếu cần, chẳng hạn như thay đổi team ID hoặc điều chỉnh các cài đặt liên quan đến signing.

## Sử dụng

### Tạo bản build IPA hoặc TIPA

Chạy script `ipabuild.sh` để tạo file IPA hoặc TIPA.

1. Đảm bảo bạn có quyền thực thi trên file script:

    ```bash
    chmod +x ipabuild.sh
    ```

2. Chạy script:

    ```bash
    ./ipabuild.sh
    ```

   Nếu bạn muốn tạo bản debug, thêm tham số `--debug`:

    ```bash
    ./ipabuild.sh --debug
    ```

### Kết quả

File IPA hoặc TIPA sẽ được tạo trong thư mục gốc của dự án với tên `noti.tipa` hoặc `noti.ipa` tùy thuộc vào lựa chọn của bạn.

## Cấu trúc Dự án

- `ContentView.swift`: Tệp Swift chính chứa giao diện người dùng và logic của ứng dụng.
- `ipabuild.sh`: Script xây dựng để tạo file IPA hoặc TIPA.
- `noti.entitlements`: File chứa các entitlements cần thiết cho ứng dụng.

## Ghi chú

Đây là một ứng dụng giả lập thông báo ngân hàng, không sử dụng cho mục đích lừa đảo hoặc gây hiểu lầm. Mục đích duy nhất của dự án này là học tập và thử nghiệm.

## Liên hệ

Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ:

- Website: https://haininh.site
- GitHub: [WeansHHN](https://github.com/WeansHHN)

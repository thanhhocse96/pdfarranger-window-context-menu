# Open in PDF Arranger — Context Menu

Thêm option "Open in PDF Arranger" vào chuột phải khi click file PDF.
Hoạt động với mọi app PDF (Foxit Reader, Foxit Editor, Edge, Chrome...).

---

## Cách cài (chọn 1 trong 2)

### Cách A — Tự động (Khuyến nghị)
1. Right-click `install.ps1` → **"Run with PowerShell"**
2. Nếu hỏi quyền Admin → cho phép
3. Script tự tìm PDF Arranger và cài xong

### Cách B — Thủ công
1. Mở `install_context_menu.reg` bằng Notepad
2. Nếu PDF Arranger **không** cài ở `C:\Program Files\PDFArranger\` thì sửa đường dẫn
3. Double-click file `.reg` → Yes → OK

---

## Cách dùng

1. Đang xem PDF trong Foxit → **click chuột phải vào file** (trong Explorer)
2. Chọn **"Open in PDF Arranger"**
3. Chỉnh sửa (xoay trang, xoá, sắp xếp...)
4. **Ctrl+S** để lưu đè file gốc
5. Foxit tự hỏi reload → chọn **Yes**

---

## Gỡ cài đặt

Double-click `uninstall_context_menu.reg`

---

## Lưu ý

- Cần quyền Admin để sửa registry `HKEY_CLASSES_ROOT`
- Nếu dùng Group Policy / MDM để deploy hàng loạt máy:
  `regedit /s install_context_menu.reg`
- Test trên Windows 10 & 11

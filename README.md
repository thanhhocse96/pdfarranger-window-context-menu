# Open in PDF Arranger — Context Menu

Add an **"Open in PDF Arranger"** option to the right-click menu when you click a PDF file.
Works with all PDF apps (Foxit Reader, Foxit Editor, Edge, Chrome...).

---

## Installation (choose 1 of 2)

### Method A — Automatic (Recommended)
1. Right-click `install.ps1` → **"Run with PowerShell"**
2. If asked for Admin rights → allow
3. The script will automatically find PDF Arranger and complete the installation

### Method B — Manual
1. Open `install_context_menu.reg` with Notepad
2. If PDF Arranger **is not** installed at `C:\Program Files\PDFArranger\` then edit the path
3. Double-click the `.reg` file → Yes → OK

---

## How to use

1. While viewing a PDF in Foxit → **right-click the file** (in Explorer)
2. Select **"Open in PDF Arranger"**
3. Edit (rotate pages, delete, reorder...)
4. **Ctrl+S** to save and overwrite the original file
5. Foxit will prompt to reload → choose **Yes**

---

## Uninstall

Double-click `uninstall_context_menu.reg`

---

## Notes

- Admin rights are required to modify the registry key **HKEY_CLASSES_ROOT**
- If using Group Policy / MDM to deploy to multiple machines:
  `regedit /s install_context_menu.reg`
- Tested on Windows 10 & 11
  
---

# Thêm "Open in PDF Arranger" và Context Menu

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

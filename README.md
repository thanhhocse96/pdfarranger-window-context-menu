# Open in PDF Arranger — Context Menu

Add **"Open in PDF Arranger"** to the right-click menu for any PDF file in Windows Explorer.

---

## Installation

### Windows 11 (Recommended)
Double-click **`install.bat`** — no configuration needed.

### Windows 10
Right-click **`install.ps1`** → **"Run with PowerShell"**  
*(Allow Admin rights if prompted)*

### Manual
1. Open `install_context_menu.reg` with Notepad
2. If PDF Arranger is **not** installed at `C:\Program Files\PDFArranger\`, update the path
3. Double-click the `.reg` file → Yes → OK

---

## Usage

1. Right-click any PDF file in Explorer → **"Open in PDF Arranger"**
2. Edit (rotate pages, delete, reorder...)
3. **Ctrl+S** to save and overwrite the original file
4. Foxit will prompt to reload → **Yes**

---

## Uninstall

Double-click **`uninstall_context_menu.reg`**

---

## Notes

- Requires Admin rights to write to `HKEY_CLASSES_ROOT`
- Silent deploy via GPO / MDM: `regedit /s install_context_menu.reg`
- Tested on Windows 10 & 11

---

---

# Thêm "Open in PDF Arranger" vào Context Menu

Thêm **"Open in PDF Arranger"** vào menu chuột phải cho file PDF trong Windows Explorer.

---

## Cài đặt

### Windows 11 (Khuyến nghị)
Double-click **`install.bat`** — không cần cấu hình gì thêm.

### Windows 10
Right-click **`install.ps1`** → **"Run with PowerShell"**  
*(Cho phép quyền Admin nếu được hỏi)*

### Thủ công
1. Mở `install_context_menu.reg` bằng Notepad
2. Nếu PDF Arranger **không** cài ở `C:\Program Files\PDFArranger\` thì sửa đường dẫn
3. Double-click file `.reg` → Yes → OK

---

## Cách dùng

1. Click chuột phải vào file PDF bất kỳ trong Explorer → **"Open in PDF Arranger"**
2. Chỉnh sửa (xoay trang, xoá, sắp xếp...)
3. **Ctrl+S** để lưu đè file gốc
4. Foxit tự hỏi reload → **Yes**

---

## Gỡ cài đặt

Double-click **`uninstall_context_menu.reg`**

---

## Lưu ý

- Cần quyền Admin để ghi vào registry `HKEY_CLASSES_ROOT`
- Deploy hàng loạt qua GPO / MDM: `regedit /s install_context_menu.reg`
- Đã test trên Windows 10 & 11

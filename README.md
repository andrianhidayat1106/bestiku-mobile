## 📝 Detail Fitur

### 1. Manajemen Tugas (Bestie Task)
Sistem manajemen tugas yang dirancang untuk efisiensi maksimal:
- **Simplify Status**: Menggunakan logic sederhana `is_done` (Boolean) untuk membedakan tugas yang sudah selesai dan yang belum.
- **Real-time Update**: Perubahan status tugas langsung tersinkronisasi ke database Supabase.
- **Priority List**: Mengurutkan tugas berdasarkan waktu pembuatan atau tenggat waktu.

### 2. Manajemen Keuangan (Bestie Wallet)
Fitur pencatatan finansial untuk memantau arus kas:
- **Transaction Logs**: Mencatat setiap pemasukan dan pengeluaran.
- **Balance Calculation**: Perhitungan saldo otomatis berdasarkan total transaksi yang masuk.
- **History View**: Melihat riwayat transaksi dalam bentuk list yang bersih.

## ⚙️ Spesifikasi Teknis

Aplikasi ini menggunakan pendekatan modern dalam pengembangan aplikasi mobile:

| Komponen | Teknologi |
| :--- | :--- |
| **Framework** | Flutter (Stable) |
| **State Management** | GetX (Controller, Binding, Reactive) |
| **Database & Auth** | Supabase |
| **Database Engine** | PostgreSQL |
| **Tools** | Get CLI (Architecture Generator) |

## 📐 Arsitektur Database
ERD dirancang secara relasional untuk memastikan integritas data antara user, task, dan wallet:
- **Tabel `users`**: Menyimpan profil dan kredensial.
- **Tabel `tasks`**: Terhubung ke `user_id` dengan kolom `title`, `description`, dan `is_done`.
- **Tabel `wallets`**: Menyimpan data transaksi finansial user.

# Flutter Futsal Booking App

Aplikasi mobile untuk booking lapangan futsal dengan fitur lengkap dan user-friendly.

## 📱 Fitur Utama

✅ **Autentikasi User**
- Login dan Registrasi
- Manajemen Profil
- Logout

✅ **Browse Lapangan**
- Daftar lapangan dengan filter kota
- Pencarian lapangan real-time
- Informasi detail lapangan
- Rating dan review

✅ **Booking Lapangan**
- Pilih tanggal booking
- Pilih jam mulai dan selesai
- Hitung total harga otomatis
- Tambah catatan pemesanan
- Simpan ke database lokal

✅ **Riwayat Pemesanan**
- Lihat semua pemesanan
- Status pemesanan real-time
- Detail booking lengkap

✅ **Profil User**
- Edit informasi profil
- Lihat data user
- Logout

## 🔧 Tech Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **Database**: SQLite (sqflite)
- **State Management**: Provider
- **UI**: Material Design 3
- **Localization**: Intl (Indonesia)
- **UUID**: Untuk generate unique ID
- **Google Fonts**: Roboto

## 📁 Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/
│   ├── booking.dart         # Model untuk booking
│   └── lapangan.dart        # Model untuk lapangan
├── services/
│   ├── auth_service.dart    # Service untuk autentikasi
│   └── database_helper.dart # Service untuk database SQLite
├── pages/
│   ├── splash_page.dart     # Splash screen
│   ├── login_page.dart      # Halaman login
│   ├── register_page.dart   # Halaman registrasi
│   ├── home_page.dart       # Halaman utama
│   ├── detail_page.dart     # Detail lapangan
│   ├── booking_page.dart    # Form booking
│   ├── history_page.dart    # Riwayat pemesanan
│   └── profile_page.dart    # Profil user
├── widgets/
│   ├── custom_button.dart   # Custom button widget
│   └── lapangan_card.dart   # Card widget untuk lapangan
└── data/
    └── dummy_lapangan.dart  # Data dummy lapangan
```

## 🚀 Cara Memulai

### Prerequisites
- Flutter SDK 3.0+
- Android SDK (API 21+)
- Java Development Kit (JDK) 11+
- Git

### Setup

1. **Clone repository**
```bash
git clone https://github.com/marzukiahmad0204-ai/booking-lapangan-futsal-flutter.git
cd booking-lapangan-futsal-flutter
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run aplikasi**
```bash
flutter run
```

## 📦 Build APK

### Debug APK
```bash
flutter build apk --debug
```

### Release APK
```bash
flutter build apk --release
```

### Split APK (Recommended)
```bash
flutter build apk --split-per-abi --release
```

### Bundle untuk Play Store
```bash
flutter build appbundle --release
```

📍 **APK akan tersimpan di:** `build/app/outputs/flutter-apk/`

Lihat [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md) untuk detail lebih lengkap.

## 📝 Demo Credentials

- **Email**: demo@example.com
- **Password**: 123456

## 🎨 UI/UX

- Material Design 3
- Responsive design
- Dark-friendly color scheme
- Smooth transitions & animations
- Intuitive navigation

## 📊 Database Schema

### Users Table
```sql
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE,
  nama TEXT,
  noHp TEXT,
  password TEXT,
  fotoProfil TEXT,
  createdAt TEXT
)
```

### Lapangan Table
```sql
CREATE TABLE lapangan (
  id TEXT PRIMARY KEY,
  nama TEXT,
  alamat TEXT,
  kota TEXT,
  hargaPerJam REAL,
  fotoCover TEXT,
  kapasitas INTEGER,
  rating REAL,
  jumlahReview INTEGER,
  fasilitas TEXT,
  deskripsi TEXT,
  tersedia INTEGER
)
```

### Booking Table
```sql
CREATE TABLE booking (
  id TEXT PRIMARY KEY,
  userId TEXT,
  lapanganId TEXT,
  lapanganNama TEXT,
  tanggalBooking TEXT,
  jamMulai TEXT,
  jamSelesai TEXT,
  totalHarga REAL,
  status TEXT,
  createdAt TEXT,
  catatan TEXT,
  FOREIGN KEY(userId) REFERENCES users(id),
  FOREIGN KEY(lapanganId) REFERENCES lapangan(id)
)
```

## 🔒 Security Features

- Password hashing (siap untuk implementasi)
- Local database encryption (siap untuk implementasi)
- Session management
- Input validation

## 🌟 Fitur yang Akan Datang

- ✨ Integrasi Payment Gateway (Midtrans, Stripe)
- ✨ Notifikasi Real-time (Firebase Cloud Messaging)
- ✨ Rating & Review System
- ✨ Riwayat Pembayaran
- ✨ Chat dengan Pemilik Lapangan
- ✨ Map Integration (Google Maps)
- ✨ QR Code Booking
- ✨ Dark Mode

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details

## 👨‍💻 Author

**Marzuki Ahmad**
- GitHub: [@marzukiahmad0204-ai](https://github.com/marzukiahmad0204-ai)
- Email: marzukiahmad0204@gmail.com

## 🤝 Contributing

Kontribusi, issues, dan feature requests sangat welcome!

## 📧 Support

Jika ada pertanyaan atau butuh bantuan, silakan buat issue di repository ini.

---

**Made with ❤️ by Marzuki Ahmad**

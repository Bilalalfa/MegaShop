# Social Commerce

Aplikasi e-commerce sosial dengan pembagian tugas tim per fitur dan arsitektur modular.

## Setup untuk Developer Baru

### Prasyarat

- Install Flutter SDK di mesin kamu.
- Pastikan `flutter doctor` bersih atau hanya ada peringatan minor.
- Siapkan editor: VS Code / Android Studio / IntelliJ.
- Pastikan device tersedia:
  - Android emulator / iOS simulator / perangkat fisik.

### Langkah Awal

1. Buka folder project ini di VS Code atau IDE.
2. Jalankan terminal di folder proyek.
3. Install dependency:

```bash
flutter pub get
```

4. Cek device yang tersedia:

```bash
flutter devices
```

5. Jalankan aplikasi:

```bash
flutter run
```

### Run di Platform Spesifik

- Android:

```bash
flutter run -d emulator-5554
```

- iOS:

```bash
flutter run -d <device_id>
```

- Web:

```bash
flutter run -d chrome
```

### Tips Bekerja di Tim

- Kalau mau mulai kerja di fitur baru, pastikan branch `main` atau `develop` sudah update.
- Periksa model dan provider sebelum ubah agar tidak bentrok dengan tim lain.
- Jika membuat komponen yang bisa dipakai banyak screen, taruh di `lib/widgets/`.
- Jangan taruh logika app di `lib/main.dart`.

---------------------------------------------------------------------------------------

### Troubleshooting Cepat

- `flutter pub get` gagal:
  - Pastikan koneksi internet.
  - Jalankan `flutter clean` lalu `flutter pub get` lagi.

- Aplikasi tidak muncul di device:
  - Cek `flutter devices`.
  - Pastikan emulator/simulator sudah aktif atau perangkat terhubung.

- Error build:
  - Jalankan `flutter clean`.
  - Kemudian `flutter pub get` dan `flutter run`.

## Struktur Proyek

- `lib/main.dart`
  - Entry point aplikasi.
  - Hanya memanggil `runApp()`.
  - Tidak ada logika di sini.

- `lib/app.dart`
  - Setup `MaterialApp`.
  - Definisikan theme, warna, font, dan route semua halaman.

- `lib/models/`
  - Struktur data yang dipakai seluruh aplikasi.
  - Model harus sama untuk semua tim agar tidak konflik.
  - `user.dart` → data login, nama, foto profil.
  - `product.dart` → nama produk, harga, gambar, deskripsi.
  - `order.dart` → item yang dibeli, total harga, status pesanan.

- `lib/providers/`
  - State management untuk data yang dibagikan antar halaman.
  - `cart_provider.dart` → isi cart, tambah/hapus item.
  - `user_provider.dart` → data user yang sedang login.
  - `product_provider.dart` → daftar produk untuk Feed & Reels.

- `lib/screens/`
  - Semua halaman tampilan aplikasi.
  - Dibagi berdasarkan menu dan tugas setiap orang.
  - `home/` → tugas Orang 1.
  - `reels/` → tugas Orang 2.
  - `post/` → tugas Orang 3.
  - `cart/` → tugas Orang 4.
  - `profile/` → tugas Orang 5.

- `lib/widgets/`
  - Komponen reusable yang dipakai oleh lebih dari satu halaman.
  - `product_card.dart` → kartu produk untuk Feed, Search, dll.
  - `custom_button.dart` → tombol dengan style konsisten.
  - `bottom_nav_bar.dart` → navigasi bawah untuk semua halaman.

- `lib/utils/`
  - Helper dan konstanta global.
  - `constants.dart` → warna, ukuran font, padding.
  - `helpers.dart` → fungsi kecil seperti format harga dan tanggal.

## Alur Data

1. `utils/` → definisi warna, font, helper umum.
2. `models/` → cetakan data aplikasi.
3. `providers/` → data yang dishare antar halaman.
4. `screens/` → tampilan menggunakan data dari provider dan model.
5. `widgets/` → komponen reusable dipakai di banyak halaman.

## Contoh Kasus

- Orang 2 klik "Add to Cart" dari Reels.
- `product_provider` dan `cart_provider` update.
- Orang 4 buka halaman Cart.
- Data cart sudah tercermin karena provider shared state.

## Task Pembagian Tim

- Orang 1: `home/` + `app.dart` routing.
- Orang 2: `reels/` + konten video dan interaksi.
- Orang 3: `post/` + upload dan post produk.
- Orang 4: `cart/` + checkout flow.
- Orang 5: `profile/`, `models/`, `providers/` user/cart/product.

## Catatan

- Gunakan icon Flutter bawaan `Icons` untuk UI sederhana.
- Jika suatu komponen mungkin dipakai di lebih dari satu screen, taruh di folder `widgets/`.
- Pastikan semua model dan provider konsisten agar integrasi antar fitur lancar.
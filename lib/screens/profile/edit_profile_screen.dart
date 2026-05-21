import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Package baru

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialUsername;
  final String initialBio;
  final String initialImageUrl;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialUsername,
    required this.initialBio,
    required this.initialImageUrl,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;

  String _currentImageUrl = '';
  File? _selectedImageFile; // Variabel penyimpan foto dari galeri

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _usernameController = TextEditingController(text: widget.initialUsername);
    _bioController = TextEditingController(text: widget.initialBio);

    // Cek apakah URL awalnya adalah path lokal (File) atau internet (HTTP)
    if (widget.initialImageUrl.startsWith('http')) {
      _currentImageUrl = widget.initialImageUrl;
    } else {
      _selectedImageFile = File(widget.initialImageUrl);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuka galeri HP
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Membuka galeri
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
        _currentImageUrl = ''; // Hapus URL internet karena pakai foto lokal
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan gambar mana yang akan ditampilkan (Lokal vs Internet)
    ImageProvider imageProvider;
    if (_selectedImageFile != null) {
      imageProvider = FileImage(_selectedImageFile!);
    } else {
      imageProvider = NetworkImage(_currentImageUrl);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BAGIAN FOTO PROFIL
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200, width: 4),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage, // Panggil fungsi galeri saat diklik
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            _buildTextField(_nameController, Icons.badge_outlined),
            const SizedBox(height: 16),

            const Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            _buildTextField(_usernameController, Icons.person_outline),
            const SizedBox(height: 16),

            const Text(
              'Bio',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            _buildTextField(_bioController, null, maxLines: 4),
            const SizedBox(height: 40),

            // TOMBOL SAVE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'username': _usernameController.text,
                    'bio': _bioController.text,
                    // Kirim path lokal jika ada, jika tidak pakai URL internet
                    'imageUrl': _selectedImageFile?.path ?? _currentImageUrl,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    IconData? icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}

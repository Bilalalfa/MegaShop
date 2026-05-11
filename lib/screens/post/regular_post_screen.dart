import 'package:flutter/material.dart';

class RegularPostScreen extends StatelessWidget {
  const RegularPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      child: Column(
        children: [
          _uploadBox(),
          const SizedBox(height: 18),
          _captionBox(),
          const SizedBox(height: 18),
          _postButton(),
        ],
      ),
    );
  }

  Widget _uploadBox() {
    return _card(
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _UploadIcon(),
            SizedBox(height: 18),
            Text(
              'Upload Image or Video',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tap to browse', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _captionBox() {
    return _card(
      height: 140,
      child: const TextField(
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Write a caption...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _postButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          'Post',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _card({required Widget child, double? height}) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _UploadIcon extends StatelessWidget {
  const _UploadIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
        ),
      ),
      child: const Icon(Icons.upload_rounded, color: Colors.white, size: 36),
    );
  }
}
import 'package:flutter/material.dart';
import 'regular_post_screen.dart';
import 'product_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isProductPost = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Create Post'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildTabSwitch(),
          ),
          Expanded(
            child: isProductPost
                ? const ProductPostScreen()
                : const RegularPostScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitch() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _tabButton('Regular Post', !isProductPost),
          _tabButton('Product Post', isProductPost),
        ],
      ),
    );
  }

  Widget _tabButton(String title, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isProductPost = title == 'Product Post';
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
            )
                : null,
            color: selected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
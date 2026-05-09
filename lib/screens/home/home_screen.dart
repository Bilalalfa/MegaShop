import 'package:flutter/material.dart';
import 'package:socialcommerce/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _products = [
    {
      'title': 'TechStyle Wireless Pro Headphones',
      'brand': 'TechStyle',
      'image': 'https://media.istockphoto.com/id/860853620/tr/foto%C4%9Fraf/beyaz-bir-arka-plan-%C3%BCzerinde-izole-mor-kulakl%C4%B1k.jpg?s=2048x2048&w=is&k=20&c=jmbsgIELbLBTWRTO5KgKifAB8rrDJTzFFekQ7VJM4vI=',
      'price': 'Rp 299',
      'likes': '1243',
      'comments': '89',
      'hasPrice': true,
    },
    {
      'title': 'UrbanFeet Minimalist White Sneakers',
      'brand': 'UrbanFeet',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRiUB0BmaMNJqZmmcjkxPmApYIEHm2y2MOuQ&s',
      'price': 'Rp 149',
      'likes': '2155',
      'comments': '134',
      'hasPrice': true,
    },
    {
      'title': 'LuxuryTime Classic Leather Watch',
      'brand': 'LuxuryTime',
      'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=80',
      'price': 'Rp 599',
      'likes': '687',
      'comments': '98',
      'hasPrice': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                itemCount: _products.length,
                separatorBuilder: (context, index) => const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  final item = _products[index];
                  return _buildProductCard(
                    title: item['title'] as String,
                    brand: item['brand'] as String,
                    imageUrl: item['image'] as String,
                    price: item['price'] as String,
                    likes: item['likes'] as String,
                    comments: item['comments'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Text('MegaShop', style: AppTextStyles.title.copyWith(fontSize: 26, color: AppColors.primary)),
          const Spacer(),
          const Icon(Icons.search, color: AppColors.textSecondary),
          const SizedBox(width: 16),
          const Icon(Icons.chat_bubble_outline, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String brand,
    required String imageUrl,
    required String price,
    required String likes,
    required String comments,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(38),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(brand, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      ),
                      Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _buildStatIcon(Icons.favorite, likes),
                      const SizedBox(width: 18),
                      _buildStatIcon(Icons.chat_bubble_outline, comments),
                      const Spacer(),
                      const Icon(Icons.share, color: AppColors.textSecondary, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(value, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  // Simulasi fetch data untuk testing skeleton dan UI
  void loadDummyProducts() {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _products = List.generate(
        10,
        (index) => Product(
          id: 'p_$index',
          title: 'Produk Keren ${index + 1}',
          description:
              'Ini adalah deskripsi produk keren ${index + 1} untuk MegaShop.',
          price: 150000.0 + (index * 50000),
          imageUrl: 'https://picsum.photos/seed/shop$index/300',
          sellerId: 'u1',
        ),
      );
      _isLoading = false;
      notifyListeners();
    });
  }
}

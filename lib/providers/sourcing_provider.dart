import 'package:flutter/material.dart';
import '../data/models/product.dart';
import '../data/mock/mock_data.dart';

class SourcingProvider extends ChangeNotifier {
  final List<Product> _products = List.from(MockData.products);
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<Product> get allProducts => _products;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  final List<String> categories = [
    'All',
    'Electronics',
    'Fashion & Apparel',
    'Home & Kitchen',
    'Beauty & Personal Care',
    'Health & Wellness',
  ];

  List<Product> get filteredProducts {
    return _products.where((product) {
      final matchesCategory = _selectedCategory == 'All' ||
          product.category.toLowerCase().contains(_selectedCategory.toLowerCase());

      final matchesQuery = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.subCategory.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesQuery;
    }).toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Product? findById(String id) {
    return _products.cast<Product?>().firstWhere(
          (p) => p!.id == id,
          orElse: () => null,
        );
  }
}

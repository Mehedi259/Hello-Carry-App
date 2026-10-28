class Product {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final double priceMin;
  final double priceMax;
  final String currency;
  final String weightRange;
  final String restriction; // e.g. "No Restriction", "Customs Approval"
  final bool isAvailable;
  final String imagePath;
  final String description;
  final List<String> keyFeatures;
  final double rating;
  final int reviewsCount;
  final bool isPopular;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.priceMin,
    required this.priceMax,
    this.currency = '\$',
    required this.weightRange,
    required this.restriction,
    required this.isAvailable,
    required this.imagePath,
    required this.description,
    required this.keyFeatures,
    this.rating = 4.9,
    this.reviewsCount = 48,
    this.isPopular = true,
  });

  String get priceRangeDisplay {
    final min = priceMin.toStringAsFixed(0);
    final max = priceMax.toStringAsFixed(0);
    return '$currency$min - $currency$max';
  }
}

class QuoteRequest {
  final String id;
  final String category;
  final String description;
  final double weightKg;
  final String pickupCountry;
  final String pickupCity;
  final String destinationCountry;
  final String destinationCity;
  final String shippingMethod; // "Air Cargo" or "Sea Freight"
  final double estimatedPriceUSD;
  final double estimatedPriceOMR;
  final double estimatedPriceBDT;
  final DateTime createdAt;
  final String status; // "Pending", "Approved", "In Review"

  const QuoteRequest({
    required this.id,
    required this.category,
    required this.description,
    required this.weightKg,
    required this.pickupCountry,
    required this.pickupCity,
    required this.destinationCountry,
    required this.destinationCity,
    required this.shippingMethod,
    required this.estimatedPriceUSD,
    required this.estimatedPriceOMR,
    required this.estimatedPriceBDT,
    required this.createdAt,
    this.status = 'Pending',
  });
}

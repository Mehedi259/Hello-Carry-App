import 'dart:math';
import 'package:flutter/material.dart';
import '../data/models/quote_request.dart';

class QuoteProvider extends ChangeNotifier {
  final List<QuoteRequest> _submittedQuotes = [];

  String _category = 'Electronics';
  String _description = '';
  double _weightKg = 2.5;
  String _pickupCountry = 'Bangladesh';
  String _pickupCity = 'Dhaka';
  String _destinationCountry = 'Oman';
  String _destinationCity = 'Muscat';
  String _shippingMethod = 'Air Cargo'; // 'Air Cargo' or 'Sea Freight'
  bool _pickupRequired = true;

  List<QuoteRequest> get submittedQuotes => _submittedQuotes;
  String get category => _category;
  String get description => _description;
  double get weightKg => _weightKg;
  String get pickupCountry => _pickupCountry;
  String get pickupCity => _pickupCity;
  String get destinationCountry => _destinationCountry;
  String get destinationCity => _destinationCity;
  String get shippingMethod => _shippingMethod;
  bool get pickupRequired => _pickupRequired;

  final List<String> categories = [
    'Electronics',
    'Fashion & Apparel',
    'Home & Kitchen',
    'Beauty & Personal Care',
    'Health & Wellness',
    'Documents & Parcels',
    'Food Items & Spices',
    'Heavy Machinery / Others',
  ];

  final List<String> shippingMethods = [
    'Air Cargo',
    'Sea Freight',
  ];

  void setCategory(String val) {
    _category = val;
    notifyListeners();
  }

  void setDescription(String val) {
    _description = val;
    notifyListeners();
  }

  void setWeightKg(double val) {
    _weightKg = val.clamp(0.5, 500.0);
    notifyListeners();
  }

  void setShippingMethod(String method) {
    _shippingMethod = method;
    notifyListeners();
  }

  void setRoute({
    required String pickupCountry,
    required String destinationCountry,
  }) {
    _pickupCountry = pickupCountry;
    _destinationCountry = destinationCountry;
    _pickupCity = pickupCountry == 'Bangladesh' ? 'Dhaka' : 'Muscat';
    _destinationCity = destinationCountry == 'Oman' ? 'Muscat' : 'Dhaka';
    notifyListeners();
  }

  void toggleRoute() {
    final tempCountry = _pickupCountry;
    _pickupCountry = _destinationCountry;
    _destinationCountry = tempCountry;

    final tempCity = _pickupCity;
    _pickupCity = _destinationCity;
    _destinationCity = tempCity;

    notifyListeners();
  }

  void setPickupRequired(bool val) {
    _pickupRequired = val;
    notifyListeners();
  }

  // Live Rate Calculation
  double get estimatedPriceUSD {
    final isAir = _shippingMethod == 'Air Cargo';
    final ratePerKg = isAir ? 9.5 : 2.8;
    final baseFee = isAir ? 15.0 : 35.0;
    final pickupFee = _pickupRequired ? 10.0 : 0.0;

    // Weight multiplier with slight bulk volume discount
    double cost = baseFee + (_weightKg * ratePerKg) + pickupFee;
    if (_weightKg > 20) {
      cost *= 0.88; // 12% bulk discount
    }
    return cost;
  }

  double get estimatedPriceOMR => estimatedPriceUSD * 0.385;
  double get estimatedPriceBDT => estimatedPriceUSD * 122.5;

  QuoteRequest submitQuote() {
    final randId = 1000 + Random().nextInt(9000);
    final quote = QuoteRequest(
      id: '#QT-$randId',
      category: _category,
      description: _description.isEmpty ? 'General $_category Freight' : _description,
      weightKg: _weightKg,
      pickupCountry: _pickupCountry,
      pickupCity: _pickupCity,
      destinationCountry: _destinationCountry,
      destinationCity: _destinationCity,
      shippingMethod: _shippingMethod,
      estimatedPriceUSD: estimatedPriceUSD,
      estimatedPriceOMR: estimatedPriceOMR,
      estimatedPriceBDT: estimatedPriceBDT,
      createdAt: DateTime.now(),
    );

    _submittedQuotes.insert(0, quote);
    notifyListeners();
    return quote;
  }

  void resetForm() {
    _category = 'Electronics';
    _description = '';
    _weightKg = 2.5;
    _shippingMethod = 'Air Cargo';
    _pickupRequired = true;
    notifyListeners();
  }
}

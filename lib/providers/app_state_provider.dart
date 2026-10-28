import 'package:flutter/material.dart';
import '../core/localization/app_strings_local.dart';

enum ActiveRoute {
  bdToOman,
  omanToBd;

  String get originCountry =>
      this == ActiveRoute.bdToOman ? 'Bangladesh' : 'Oman';
  String get destinationCountry =>
      this == ActiveRoute.bdToOman ? 'Oman' : 'Bangladesh';
  String get originCode => this == ActiveRoute.bdToOman ? 'BD' : 'OM';
  String get destinationCode => this == ActiveRoute.bdToOman ? 'OM' : 'BD';
}

class AppStateProvider extends ChangeNotifier {
  bool _isOnboarded = false; // Start on Onboarding screen
  int _currentNavIndex = 0;
  ActiveRoute _activeRoute = ActiveRoute.bdToOman;
  String _selectedCurrency = 'USD'; // 'USD', 'OMR', 'BDT'
  String _selectedLanguage = 'English'; // 'English' or 'বাংলা'

  bool get isOnboarded => _isOnboarded;
  int get currentNavIndex => _currentNavIndex;
  ActiveRoute get activeRoute => _activeRoute;
  String get selectedCurrency => _selectedCurrency;
  String get selectedLanguage => _selectedLanguage;

  bool get isBengali => AppLocal.isBn(_selectedLanguage);

  String t(String key) => AppLocal.t(key, _selectedLanguage);

  void completeOnboarding() {
    _isOnboarded = true;
    notifyListeners();
  }

  void resetOnboarding() {
    _isOnboarded = false;
    notifyListeners();
  }

  void setNavIndex(int index) {
    if (_currentNavIndex != index) {
      _currentNavIndex = index;
      notifyListeners();
    }
  }

  void toggleRoute() {
    _activeRoute = _activeRoute == ActiveRoute.bdToOman
        ? ActiveRoute.omanToBd
        : ActiveRoute.bdToOman;
    notifyListeners();
  }

  void setRoute(ActiveRoute route) {
    _activeRoute = route;
    notifyListeners();
  }

  void setCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  // Currency converter helper
  String formatPrice(double priceInUSD) {
    switch (_selectedCurrency) {
      case 'OMR':
        final omr = priceInUSD * 0.385;
        return '${omr.toStringAsFixed(1)} OMR';
      case 'BDT':
        final bdt = priceInUSD * 122.5;
        return '৳${bdt.toStringAsFixed(0)} BDT';
      case 'USD':
      default:
        return '\$${priceInUSD.toStringAsFixed(0)}';
    }
  }
}

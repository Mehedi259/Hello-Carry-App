class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String avatarPath;
  final int totalShipments;
  final int inTransitCount;
  final int deliveredCount;
  final String defaultCurrency;
  final String language;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarPath,
    required this.totalShipments,
    required this.inTransitCount,
    required this.deliveredCount,
    this.defaultCurrency = 'USD',
    this.language = 'English',
  });
}

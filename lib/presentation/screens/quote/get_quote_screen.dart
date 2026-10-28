import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../providers/quote_provider.dart';
import '../../widgets/country_flag_pill.dart';

class GetQuoteScreen extends StatefulWidget {
  final String? initialCategory;
  final String? initialDescription;

  const GetQuoteScreen({
    super.key,
    this.initialCategory,
    this.initialDescription,
  });

  @override
  State<GetQuoteScreen> createState() => _GetQuoteScreenState();
}

class _GetQuoteScreenState extends State<GetQuoteScreen> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _weightController = TextEditingController(text: '2.5');

  @override
  void initState() {
    super.initState();
    final quoteProvider = context.read<QuoteProvider>();
    if (widget.initialCategory != null) {
      quoteProvider.setCategory(widget.initialCategory!);
    }
    if (widget.initialDescription != null) {
      _descController.text = widget.initialDescription!;
      quoteProvider.setDescription(widget.initialDescription!);
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submit() {
    final quoteProvider = context.read<QuoteProvider>();
    quoteProvider.setDescription(_descController.text);
    final quote = quoteProvider.submitQuote();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Quote Request Submitted!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Reference ID: ${quote.id}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildModalRow('Route', '${quote.pickupCountry} → ${quote.destinationCountry}'),
                  _buildModalRow('Category', quote.category),
                  _buildModalRow('Weight', '${quote.weightKg} kg'),
                  _buildModalRow('Method', quote.shippingMethod),
                  const Divider(height: 12),
                  _buildModalRow(
                    'Estimated Rate',
                    '\$${quote.estimatedPriceUSD.toStringAsFixed(0)} (~${quote.estimatedPriceOMR.toStringAsFixed(1)} OMR)',
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Our Oman & Dhaka cargo team will contact you within 30 minutes with final discounted booking rates.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context); // return to previous screen
                },
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: isBold ? AppColors.accent : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quoteProvider = context.watch<QuoteProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Get a Quote',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Hero Banner
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                      AppAssets.quoteBanner,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.2),
                            Colors.black.withValues(alpha: 0.75),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Get a Quote for Your Shipment',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Tell us what you want to ship and we'll calculate the best rate.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Form Container
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Dropdown
                  const Text(
                    'Product Category',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: quoteProvider.category,
                        items: quoteProvider.categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat, style: const TextStyle(fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) quoteProvider.setCategory(val);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'Product Description (Optional)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descController,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Describe items, brand, fragile requirements...',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Estimated Weight
                  const Text(
                    'Estimated Weight',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _weightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          decoration: const InputDecoration(
                            suffixText: 'kg',
                            suffixStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.accent,
                            ),
                          ),
                          onChanged: (val) {
                            final parsed = double.tryParse(val);
                            if (parsed != null) {
                              quoteProvider.setWeightKg(parsed);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Quick weight stepper
                      IconButton(
                        onPressed: () {
                          final current = quoteProvider.weightKg;
                          if (current > 1.0) {
                            final next = current - 1.0;
                            quoteProvider.setWeightKg(next);
                            _weightController.text = next.toStringAsFixed(1);
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline_rounded),
                        color: AppColors.accent,
                      ),
                      IconButton(
                        onPressed: () {
                          final next = quoteProvider.weightKg + 1.0;
                          quoteProvider.setWeightKg(next);
                          _weightController.text = next.toStringAsFixed(1);
                        },
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        color: AppColors.accent,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Shipping Method (Air Cargo vs Sea Freight)
                  const Text(
                    'Shipping Method',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMethodCard(
                          title: 'Air Cargo Express',
                          speed: '3 - 5 Days',
                          icon: Icons.flight_takeoff_rounded,
                          isSelected: quoteProvider.shippingMethod == 'Air Cargo',
                          onTap: () => quoteProvider.setShippingMethod('Air Cargo'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMethodCard(
                          title: 'Sea Freight Economy',
                          speed: '15 - 20 Days',
                          icon: Icons.directions_boat_filled_rounded,
                          isSelected: quoteProvider.shippingMethod == 'Sea Freight',
                          onTap: () => quoteProvider.setShippingMethod('Sea Freight'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Pickup & Destination Route
                  const Text(
                    'Pickup & Destination Route',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CountryFlagPill(
                          countryCode: quoteProvider.pickupCountry == 'Bangladesh' ? 'BD' : 'OM',
                          countryName: quoteProvider.pickupCountry,
                        ),
                        IconButton(
                          onPressed: () => quoteProvider.toggleRoute(),
                          icon: const Icon(Icons.swap_horiz_rounded, color: AppColors.accent),
                        ),
                        CountryFlagPill(
                          countryCode: quoteProvider.destinationCountry == 'Oman' ? 'OM' : 'BD',
                          countryName: quoteProvider.destinationCountry,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Live Rate Calculation Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estimated Total Rate',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '\$${quoteProvider.estimatedPriceUSD.toStringAsFixed(0)} USD',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '~${quoteProvider.estimatedPriceOMR.toStringAsFixed(1)} OMR',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '~${quoteProvider.estimatedPriceBDT.toStringAsFixed(0)} BDT',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Submit Request Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send_rounded, size: 18),
                      label: const Text(
                        'Submit Request',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodCard({
    required String title,
    required String speed,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withValues(alpha: 0.08) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.accent : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            Text(
              speed,
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

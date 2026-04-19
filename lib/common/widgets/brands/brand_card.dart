import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/t_circular_image.dart';
import '../texts/t_brand_title_text_with_verified_icon.dart';

// A card widget representing a brand.
class TBrandCard extends StatelessWidget {
  /// Default constructor for the TBrandCard.
  ///
  /// Parameters:
  ///   - brand: The brand model to display.
  ///   - showBorder: A flag indicating whether to show a border around the card.
  ///   - onTap: Callback function when the card is tapped.
  const TBrandCard({
    super.key,
    required this.brand,
    required this.showBorder,
    this.onTap,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final cardBackgroundColor = isDark ? TColors.dark : TColors.white;

    return GestureDetector(
      onTap: onTap,
      /// Container Design
      child: TRoundedContainer(
        showBorder: showBorder,
        backgroundColor: cardBackgroundColor,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCoverImage(isDark),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// -- Icon
                Flexible(
                  child: TCircularImage(
                    image: brand.image.isNotEmpty ? brand.image : 'https://via.placeholder.com/150?text=Logo',
                    isNetworkImage: true,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems / 2),

                /// -- Texts
                // [Expanded] & Column [MainAxisSize.min] is important to keep the elements in the vertical center and also
                // to keep text inside the boundaries.
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TBrandTitleWithVerifiedIcon(
                        title: _placeholderText(brand.name, fallback: 'Retailer name'),
                        brandTextSize: TextSizes.large,
                        showVerifiedIcon: brand.isVerified,
                        iconColor: Colors.blue,
                      ),
                      Text(
                        '${brand.productsCount} products',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              _placeholderText(brand.description, fallback: 'Description coming soon'),
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildDetailRow(context, Iconsax.sms, _placeholderText(brand.contactEmail, fallback: 'No email available yet')),
            _buildDetailRow(context, Iconsax.call, _placeholderText(brand.contactPhone, fallback: 'No phone available yet')),
            _buildDetailRow(context, Iconsax.global, _placeholderText(brand.website, fallback: 'No website available yet')),
            _buildDetailRow(context, Iconsax.location, _buildAddress()),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: TSizes.spaceBtwItems / 2,
              runSpacing: TSizes.spaceBtwItems / 2,
              children: _buildSocialChips(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage(bool isDark) {
    final fallbackColor = isDark ? TColors.darkerGrey : TColors.grey.withOpacity(0.2);

    if (brand.coverImage.trim().isEmpty) {
      return TRoundedContainer(
        height: 110,
        width: double.infinity,
        backgroundColor: fallbackColor,
        child: const Center(
          child: Text('Cover image coming soon'),
        ),
      );
    }

    return TRoundedContainer(
      height: 110,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        child: Image.network(
          brand.coverImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(
              'Cover image unavailable',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          },
        ),
      ),
    );
  }

  String _buildAddress() {
    final pieces = [
      brand.addressLine1.trim(),
      brand.addressLine2.trim(),
      brand.city.trim(),
      brand.state.trim(),
      brand.postalCode.trim(),
      brand.country.trim(),
    ].where((value) => value.isNotEmpty).toList();

    if (pieces.isEmpty) return 'Address not available yet';
    return pieces.join(', ');
  }

  List<Widget> _buildSocialChips(BuildContext context) {
    final socials = brand.socialLinks.entries.where((entry) => entry.value.trim().isNotEmpty).toList();

    if (socials.isEmpty) {
      return [
        Chip(
          label: Text(
            'Social media links coming soon',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ];
    }

    return socials
        .map(
          (entry) => Chip(
            avatar: const Icon(Iconsax.link_1, size: TSizes.iconSm),
            label: Text('${entry.key}: ${entry.value}'),
          ),
        )
        .toList();
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: TSizes.iconSm, color: TColors.primary),
          const SizedBox(width: TSizes.xs),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  String _placeholderText(String? value, {required String fallback}) {
    if (value == null || value.trim().isEmpty) return fallback;
    return value.trim();
  }
}

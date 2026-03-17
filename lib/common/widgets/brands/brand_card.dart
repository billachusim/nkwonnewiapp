import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
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
    return Semantics(
      button: onTap != null,
      enabled: onTap != null,
      label: 'Brand card for ${brand.name}',
      hint: onTap != null ? 'Open brand products for ${brand.name}' : null,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
          hoverColor: TColors.primary.withOpacity(0.08),
          focusColor: TColors.primary.withOpacity(0.14),
          highlightColor: TColors.primary.withOpacity(0.12),
          splashColor: TColors.primary.withOpacity(0.16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            /// Container Design
            child: TRoundedContainer(
              showBorder: showBorder,
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(TSizes.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// -- Icon
                  Flexible(
                    child: TCircularImage(
                      image: brand.image,
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
                        TBrandTitleWithVerifiedIcon(title: brand.name, brandTextSize: TextSizes.large),
                        Text(
                          '${brand.productsCount ?? 0} products',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

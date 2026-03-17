import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../images/t_circular_image.dart';
import '../texts/t_brand_title_text.dart';

/// A widget that displays an image with text below it in a vertical arrangement.
class TVerticalImageAndText extends StatelessWidget {
  /// Constructor for [TVerticalImageAndText].
  const TVerticalImageAndText({
    Key? key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.textColor = TColors.white,
  }) : super(key: key);

  /// The image asset path or URL.
  final String image;

  /// The text to be displayed below the image.
  final String title;

  /// The color of the text.
  final Color textColor;

  /// Flag indicating whether the image is loaded from the network.
  final bool isNetworkImage;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// Callback function when the widget is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isInteractive = onTap != null;

    return Padding(
      padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
      child: Semantics(
        button: isInteractive,
        enabled: isInteractive,
        label: 'Category item $title',
        hint: isInteractive ? 'Open products for $title' : null,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
            hoverColor: TColors.primary.withOpacity(0.08),
            focusColor: TColors.primary.withOpacity(0.14),
            highlightColor: TColors.primary.withOpacity(0.12),
            splashColor: TColors.primary.withOpacity(0.16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: Column(
                children: [
                  TCircularImage(
                    width: 85,
                    height: 82,
                    image: image,
                    fit: BoxFit.cover,
                    padding: TSizes.sm * 0.1,
                    isNetworkImage: isNetworkImage,
                    backgroundColor: backgroundColor ?? TColors.white,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  SizedBox(
                    width: 100,
                    child: TBrandTitleText(
                      title: title,
                      color: textColor,
                      maxLines: 1,
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

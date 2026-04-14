import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/formatters/formatter.dart';
import '../../../../utils/helpers/pricing_calculator.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key, required this.subTotal});

  final double subTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// -- Sub Total
        Row(
          children: [
            Expanded(child: Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium)),
            Text(TFormatter.formatCurrency(subTotal), style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// -- Shipping Fee
        Row(
          children: [
            Expanded(child: Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium)),
            Text(TFormatter.formatCurrency(double.parse(TPricingCalculator.calculateShippingCost(subTotal, 'NG'))),
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// -- Tax Fee
        Row(
          children: [
            Expanded(child: Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium)),
            Text(TFormatter.formatCurrency(double.parse(TPricingCalculator.calculateTax(subTotal, 'NG'))),
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// -- Order Total
        Row(
          children: [
            Expanded(child: Text('Order Total', style: Theme.of(context).textTheme.titleMedium)),
            Text(TFormatter.formatCurrency(TPricingCalculator.calculateTotalPrice(subTotal, 'NG')),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}

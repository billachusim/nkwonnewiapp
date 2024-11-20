import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';

class TListLayout extends StatelessWidget {
  const TListLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemHeight = 80.0, // Default height for list items
  });

  final int itemCount;
  final double itemHeight; // Height for each item
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight, // Set height for the ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.gridViewSpacing / 2), // Adjust padding as needed
            child: itemBuilder(context, index),
          );
        },
      ),
    );
  }
}
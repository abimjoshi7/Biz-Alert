import 'package:flutter/material.dart';

extension CardView on Card {
  static Card cornerRound(BuildContext context, {Widget? child}) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

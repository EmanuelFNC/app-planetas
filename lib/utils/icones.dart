import 'package:flutter/material.dart';

IconData getIconData(int? codePoint) {
  const allowedIcons = <IconData>[
    Icons.public,
    Icons.home,
    Icons.whatshot,
    Icons.star,
    Icons.terrain,
    Icons.satellite,
    Icons.rocket_launch,
    Icons.wb_sunny,
    Icons.brightness_2,
    Icons.brightness_3,
    Icons.explore,
    Icons.adjust,
    Icons.blur_circular,
    Icons.lens,
    Icons.bubble_chart,
    Icons.auto_awesome,
  ];

  if (codePoint != null) {
    for (var icon in allowedIcons) {
      if (icon.codePoint == codePoint) return icon;
    }
  }
  return Icons.help; // Ícone padrão caso o codePoint não seja encontrado
}

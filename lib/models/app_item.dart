import 'package:flutter/material.dart';

class AppItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  AppItem(this.icon, this.label, this.onTap);
}

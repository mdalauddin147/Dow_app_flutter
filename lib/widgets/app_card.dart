import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_item.dart';

class AppCard extends StatelessWidget {
  final AppItem item;

  const AppCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF5722),
      child: InkWell(
        onTap: item.onTap,
        child: SizedBox(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(item.icon, color: Colors.white),
                const SizedBox(height: 8),
                Text(item.label, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_item.dart';

class AppProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  late final List<AppItem> _items;
  List<AppItem> _filteredItems = [];

  List<AppItem> get filteredItems => _filteredItems;

  AppProvider() {
    _initializeItems();
    searchController.addListener(_filterItems);
  }

  void _initializeItems() {
    _items = [
      AppItem(FontAwesomeIcons.tiktok, 'Tiktok', () => _launchURL('https://www.tiktok.com/')),
      AppItem(FontAwesomeIcons.snapchat, 'Snapchat', () => _launchURL('https://www.snapchat.com/')),
      AppItem(FontAwesomeIcons.images, 'Album', () => _launchURL('https://photos.google.com')),
      AppItem(FontAwesomeIcons.message, 'Chatgpt', () => _launchURL('https://chatgpt.com/')),
      AppItem(FontAwesomeIcons.phone, 'Phone', () => _launchURL('tel:+1234567890')),
      AppItem(FontAwesomeIcons.instagram, 'Instagram', () => _launchURL('https://www.instagram.com')),
      AppItem(FontAwesomeIcons.facebook, 'Facebook', () => _launchURL('https://www.facebook.com')),
      AppItem(FontAwesomeIcons.motorcycle, 'Pathao', () => _launchURL('https://pathao.com/np/')),
      AppItem(FontAwesomeIcons.map, 'Map', () => _launchURL('https://www.google.com/maps/search/?api=1&query=New+York')),
      AppItem(FontAwesomeIcons.google, 'Google', () => _launchURL('https://www.google.com/')),
    ];
    _filteredItems = _items;
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    _filteredItems = _items.where((item) => item.label.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

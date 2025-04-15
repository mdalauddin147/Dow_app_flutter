import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyAppList());
}

class MyAppList extends StatelessWidget {
  const MyAppList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removed debug banner
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF7093FF),
        cardColor: const Color(0xFFFFFFFF),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<_AppItem> _items = [];
  List<_AppItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();

    _items = [
      _AppItem(FontAwesomeIcons.tiktok, 'Tiktok', () {
        _launchURL('https://www.tiktok.com/');
      }),
      _AppItem(FontAwesomeIcons.snapchat, 'Snapchat', () {
        _launchURL('https://www.snapchat.com/');
      }),
      _AppItem(FontAwesomeIcons.images, 'Album', () {
        _launchURL('https://photos.google.com');
      }),
      _AppItem(FontAwesomeIcons.message, 'Chatgpt', () {
        _launchURL('https://chatgpt.com/');
      }),
      _AppItem(FontAwesomeIcons.phone, 'Phone', () {
        _launchURL('tel:+1234567890');
      }),
      _AppItem(FontAwesomeIcons.instagram, 'Instagram', () {
        _launchURL('https://www.instagram.com');
      }),
      _AppItem(FontAwesomeIcons.facebook, 'Facebook', () {
        _launchURL('https://www.facebook.com');
      }),
      _AppItem(FontAwesomeIcons.motorcycle, 'Pathao ', () {
        _launchURL('https://pathao.com/np/');
      }),
      _AppItem(FontAwesomeIcons.map, 'Map', () {
        _launchURL('https://www.google.com/maps/search/?api=1&query=New+York');
      }),
      _AppItem(FontAwesomeIcons.google, 'Google', () {
        _launchURL('https://www.google.com/');
      }),
    ];

    _filteredItems = _items;

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredItems = _items
            .where((item) => item.label.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget buildCenteredCard(_AppItem item) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'All in One',
          style: TextStyle(color: Colors.redAccent),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF330066),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return buildCenteredCard(_filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AppItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _AppItem(this.icon, this.label, this.onTap);
}

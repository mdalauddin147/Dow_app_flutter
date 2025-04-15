import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final tapCountProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(const ProviderScope(child: MyAppList()));
}

class MyAppList extends StatelessWidget {
  const MyAppList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF7093FF), // VS Code bg
        cardColor: const Color(0xFFFFFFFF),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<_AppItem> _items = [];
  List<_AppItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();

    _items = [
      _AppItem(FontAwesomeIcons.map, 'Map', () {
        _launchURL('https://www.google.com/maps/search/?api=1&query=New+York');
      }),
      _AppItem(FontAwesomeIcons.images, 'Album', () {
        _launchURL('https://photos.google.com');
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
    final tapCount = ref.watch(tapCountProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E), // VS Code AppBar color
        title: const Text(
          'My App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          const SizedBox(height: 10),
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: const Color(0xFF2D2D2D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'You tapped: $tapCount times',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          ..._filteredItems.map(buildCenteredCard).toList(),
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

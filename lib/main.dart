import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Riverpod provider to track number of taps
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
      theme: ThemeData(primarySwatch: Colors.blue),
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
  Future<void> launchExternalUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _openGoogleMaps() {
    final Uri mapUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=New+York',
    );
    launchExternalUrl(mapUrl);
  }

  void _openAlbum() {
    final Uri albumUrl = Uri.parse('https://photos.google.com');
    launchExternalUrl(albumUrl);
  }

  void _openPhoneDialer() {
    final Uri phoneUrl = Uri.parse('tel:+1234567890');
    launchExternalUrl(phoneUrl);
  }

  void _openInstagram() {
    final Uri instagramUrl = Uri.parse('https://www.instagram.com');
    launchExternalUrl(instagramUrl);
  }

  void _openFacebook() {
    final Uri facebookUrl = Uri.parse('https://www.facebook.com');
    launchExternalUrl(facebookUrl);
  }

  @override
  Widget build(BuildContext context) {
    final tapCount = ref.watch(tapCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('My App'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref.read(tapCountProvider.notifier).state++;
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Center(child: Text('You tapped: $tapCount times')),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.map),
              title: const Center(child: Text('Map')),
              onTap: _openGoogleMaps,
            ),
          ),
          Card(
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.images),
              title: const Center(child: Text('Album')),
              onTap: _openAlbum,
            ),
          ),
          Card(
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.phone),
              title: const Center(child: Text('Phone')),
              onTap: _openPhoneDialer,
            ),
          ),
          Card(
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.instagram),
              title: const Center(child: Text('Instagram')),
              onTap: _openInstagram,
            ),
          ),
          Card(
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.facebook),
              title: const Center(child: Text('Facebook')),
              onTap: _openFacebook,
            ),
          ),
        ],
      ),
    );
  }
}

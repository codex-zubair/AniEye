import 'package:flutter/material.dart';

import '../widgets/brand.dart';
import 'about_screen.dart';
import 'series_list_screen.dart';

/// Root shell with the two AniEye destinations.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: BrandHeader(showSubtitle: _index == 0),
        actions: const <Widget>[
          SizedBox(width: 12),
          Center(child: OfflineChip()),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _index,
          children: const <Widget>[
            SeriesListScreen(),
            AboutScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) => setState(() => _index = i),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.playlist_play_outlined),
            selectedIcon: Icon(Icons.playlist_play_rounded),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            selectedIcon: Icon(Icons.info_rounded),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

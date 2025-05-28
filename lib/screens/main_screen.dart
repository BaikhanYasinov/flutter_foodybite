import 'package:flutter/material.dart';
import 'package:flutter_foodybite/screens/add.dart';
import 'package:flutter_foodybite/screens/home.dart';
import 'package:flutter_foodybite/screens/label.dart';
import 'package:flutter_foodybite/screens/profile.dart';
import 'notifications.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const _tabIcons = <IconData>[
    Icons.home_outlined,
    Icons.label_outlined,
    Icons.add,
    Icons.notifications_outlined,
    Icons.person_outlined,
  ];

  static const _activeTabIcons = <IconData>[
    Icons.home,
    Icons.label,
    Icons.add,
    Icons.notifications,
    Icons.person,
  ];

  // Исправленный список страниц с const конструкторами
  static final _pages = <Widget>[
    Home(),
    const Label(key: ValueKey('label')),
    const Add(key: ValueKey('add')),
    const Notifications(key: ValueKey('notifications')),
    const Profile(key: ValueKey('profile')),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  Widget _buildTabIcon(int index) {
    final isActive = _currentPage == index;
    final icon = isActive ? _activeTabIcons[index] : _tabIcons[index];
    
    return Padding(
      padding: EdgeInsets.only(
        left: index == 3 ? 30 : 0,
        right: index == 1 ? 30 : 0,
      ),
      child: IconButton(
        icon: Icon(icon, size: 24),
        color: isActive
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        onPressed: () => _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: _BottomAppBar(
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabIcon(0),
              _buildTabIcon(1),
              const SizedBox(width: 48),
              _buildTabIcon(3),
              _buildTabIcon(4),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: colorScheme.tertiaryContainer,
        foregroundColor: colorScheme.onTertiaryContainer,
        child: const Icon(Icons.add),
        onPressed: () => _pageController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _BottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double notchMargin;
  final Widget child;

  const _BottomAppBar({
    required this.notchMargin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      height: kBottomNavigationBarHeight + 8,
      padding: EdgeInsets.zero,
      notchMargin: notchMargin,
      shape: const CircularNotchedRectangle(),
      child: child,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kBottomNavigationBarHeight + 8);
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'screens/tarot_select_screen.dart';
import 'theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const FortuneApp());
}

class FortuneApp extends StatelessWidget {
  const FortuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COSMIC FLOW',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.background,
          primary: AppColors.lavender,
          secondary: AppColors.pink,
          onSurface: AppColors.textPrimary,
        ),
        fontFamily: 'sans-serif',
      ),
      home: const AppShell(),
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        TarotSelectScreen.routeName: (_) => const TarotSelectScreen(),
      },
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(onDrawFortune: () => setState(() => _index = 1)),
          const TarotSelectScreen(),
          const _PlaceholderTab(label: '사주/별자리'),
          const _PlaceholderTab(label: '보관함'),
        ],
      ),
      bottomNavigationBar: _CosmicBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _CosmicBottomNav extends StatelessWidget {
  const _CosmicBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const items = [
      (icon: Icons.nightlight_round, label: '오늘의 운세'),
      (icon: Icons.style_outlined, label: '타로'),
      (icon: Icons.explore_outlined, label: '사주/별자리'),
      (icon: Icons.inventory_2_outlined, label: '보관함'),
    ];

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(color: AppColors.border.withValues(alpha: 0.35)),
        ),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = currentIndex == i;
          final item = items[i];
          return Expanded(
            child: InkWell(
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selected)
                    Container(
                      width: 24,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lavender,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lavender.withValues(alpha: 0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    )
                  else
                    const SizedBox(height: 8),
                  Icon(
                    item.icon,
                    size: 20,
                    color: selected
                        ? AppColors.lavender
                        : AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 10,
                      color: selected
                          ? AppColors.lavender
                          : AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
      ),
    );
  }
}

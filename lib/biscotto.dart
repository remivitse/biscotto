import 'package:flutter/material.dart';

import 'biscotto_search_page.dart';

class Biscotto extends StatelessWidget {
  static const Color primary = Color(0xFF701F15);
  static const Color primaryDark = Color(0xFF4D140F);
  static const Color primaryLight = Color(0xFFFBF5F4);
  static const Color accent = Color(0xFF136F63);
  static const Color accentDark = Color(0xFF000F08);

  const Biscotto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biscotto',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Biscotto.primary,
          secondary: Biscotto.accent,
          background: Biscotto.primaryLight,
          onBackground: Biscotto.primaryDark,
        ),
      ),
      home: const BiscottoSearchPage(title: 'Biscotto'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/font_styles.dart';
import 'core/theme_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Launches',
      theme: ThemeData(
        colorScheme: mainAppColorTheme,
        useMaterial3: true,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Text(
                'SpaceX Launches',
                style: appHeadersText,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 216,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Mission",
              style: appHeadersText,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spacex_launches/features/rocket_launcher_list/presentation/widgets/schedule_list.dart';

import 'core/text_styles.dart';
import 'core/theme_colors.dart';
import 'features/rocket_launcher_list/presentation/widgets/image_carousel.dart';

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
            const SizedBox(height: 24),
            Center(
              child: Text(
                'SpaceX Launches',
                style: appHeadersText,
              ),
            ),
            const SizedBox(height: 24),
            const ImageCarousel(),
            const SizedBox(height: 24),
            Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "Mission",
                  style: appHeadersText,
                ),
              ],
            ),
            const ScheduleList(),
          ],
        ),
      ),
    );
  }
}

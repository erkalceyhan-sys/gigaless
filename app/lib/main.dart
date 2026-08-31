import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/services/ad_service.dart';
import 'features/gallery/controllers/swipe_deck_controller.dart';
import 'features/gallery/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Ads
  await AdService.initialize();

  runApp(const GigalessApp());
}

class GigalessApp extends StatelessWidget {
  const GigalessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SwipeDeckController()),
      ],
      child: MaterialApp(
        title: 'Gigaless',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}

import 'package:dream_craft/providers/auth_provider.dart';
import 'package:dream_craft/providers/category_provider.dart';
import 'package:dream_craft/screens/wrapper.dart';
import 'package:dream_craft/screens/auth/login_screen.dart';
import 'package:dream_craft/theme/theme_provider.dart';
import 'package:dream_craft/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'generated/codegen_loader.g.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uk')],
      path: 'assets/translations',

      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => Auth()),
          ),
          ChangeNotifierProvider(
            create: ((context) => CategoryProvider()),
          ),
          ChangeNotifierProvider(
            create: ((context) => ThemeProvider()..getSavedTheme()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _attemptAuthentication() async {
    String? key = await Utils.getToken();

    Provider.of<Auth>(context, listen: false).getUser(key);
  }

  @override
  void initState() {
    super.initState();
    _attemptAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authProvider, child) {
        if (authProvider.authenticated) {
          return const Wrapper();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
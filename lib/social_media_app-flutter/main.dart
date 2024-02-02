import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../whisber/firebase_options.dart';
import 'sm/controllers/authController.dart';
import 'sm/controllers/userController.dart';
import 'sm/utils/theme.dart';
import 'sm/utils/utils.dart';
import 'sm/view/authScreens/loginScreen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'sm/view/mainScreen.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', ''), Locale('my', '')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(
        child: SMapp(),
      ),
    ),
  );
}

//*******************************************/
class SMapp extends ConsumerStatefulWidget {
  const SMapp({super.key});

  @override
  ConsumerState<SMapp> createState() => _SMappState();
}

class _SMappState extends ConsumerState<SMapp> {
  bool loggedIn = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      initThemeData();
    });
    super.initState();
  }

  initThemeData() {
    ref.watch(themeControllerProvider.notifier).getCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeControllerProvider),
      home: ref.watch(authStateProvider).when(data: (data) {
        if (data != null) {
          currentUserId = data.uid;
          ref.read(userControllerProvider.notifier).getCurrentUser();
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      }, error: (error, s) {
        return errorWidget("${error}error");
      }, loading: () {
        return loadingWidget();
      }),
    );
  }
}

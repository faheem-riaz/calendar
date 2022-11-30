import 'package:calendar/screens/error.dart';
import 'package:calendar/screens/home.dart';
import 'package:calendar/utils/calendar_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/calendar/v3.dart' as cal;

Future<void> main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/calendar',
      ],
    );

    try {
      await googleSignIn.signIn();
      final client = await googleSignIn.authenticatedClient();
      if (client == null) {
        debugPrint('client is null');
        runApp(const ErrorApp());
      } else {
        CalendarClient.calendar = cal.CalendarApi(client);
        runApp(const MyApp());
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
      runApp(const ErrorApp());
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: const Home(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: const ErrorScreen(),
    );
  }
}

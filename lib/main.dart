import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/responsive/responsive_layout_screen.dart';
// import 'package:flutter_instagram/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/screens/mobile_screen_layout.dart';
import 'package:flutter_instagram/screens/singup_screen.dart';
import 'package:flutter_instagram/screens/web_screen_layout.dart';
import 'package:flutter_instagram/secrets.dart';
// import 'package:flutter_instagram/screens/singup_screen.dart';
// import 'package:flutter_instagram/screens/mobile_screen_layout.dart';
// import 'package:flutter_instagram/screens/web_screen_layout.dart';
import 'package:flutter_instagram/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some internal error occurred'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

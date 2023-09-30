import 'package:flutter/material.dart';

// 웹 스크린일 때
class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is web!'),
      ),
    );
  }
}

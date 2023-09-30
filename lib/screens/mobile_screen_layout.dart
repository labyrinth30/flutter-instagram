import 'package:flutter/material.dart';

// 모바일 스크린일 때
class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is mobile!'),
      ),
    );
  }
}

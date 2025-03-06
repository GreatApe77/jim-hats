import 'package:flutter/material.dart';

class SplahPage extends StatelessWidget {
  const SplahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

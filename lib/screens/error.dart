import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error_outline_outlined, color: Colors.red, size: 50),
              Text('Some thing went wrong,\nPlease restart your app'),
            ],
          ),
        ),
      ),
    );
  }
}

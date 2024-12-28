import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        children: [
          Image.asset(
            "asset/img/logo/logo.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 16,
          ),
          CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

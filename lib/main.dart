import 'package:credit_card_transactions/core/config/injection_container.dart';
import 'package:credit_card_transactions/core/constants/color_constants.dart';
import 'package:credit_card_transactions/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Transactions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

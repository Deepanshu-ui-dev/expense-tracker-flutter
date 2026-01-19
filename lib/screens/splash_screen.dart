import 'dart:async';
import 'package:flutter/material.dart';
import 'package:expense_app/widgets/expenses.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //  Splash delay before navigating to main screen
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Expenses()),
        // ↑ pushReplacement removes splash from stack
        // ↑ user can’t go back to splash screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // ↑ Using theme colorScheme keeps splash consistent with app theme

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      // ↑ Soft background instead of harsh primary color

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // ↑ Keeps content centered vertically (no stretching)

          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              size: 80,
              // ↑ Large icon for strong brand identity

              color: colorScheme.onPrimaryContainer,
              // ↑ Proper contrast against background
            ),

            const SizedBox(height: 16),

            Text(
              'Expense Tracker',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    // ↑ Makes app name stand out (brand emphasis)

                    color: colorScheme.onPrimaryContainer,
                  ),
            ),

            const SizedBox(height: 8),

            Text(
              'Track your daily spending',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                    // ↑ Reduced opacity → subtle secondary text
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

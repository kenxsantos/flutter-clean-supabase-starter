import 'package:flutter/material.dart';
import 'package:flutter_clean_supabase_starter/shared/components/slide_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(20),
                width: 380,
                height: 380,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAC898),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "App Name",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      "App Tagline",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              const SlideButton(),
            ],
          ),
        ),
      ),
    );
  }
}

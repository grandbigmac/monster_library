import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monster_library/frames/base_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.amber,
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: TextTheme(

            //Titles
            //Used to title pages / modals
            titleLarge: TextStyle(
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
            ),

            //Headlines
            //Used at the top of new sections
            headlineLarge: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.sizeOf(context).shortestSide * 0.06,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Colors.amber,
              fontSize: MediaQuery.sizeOf(context).shortestSide * 0.05,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.sizeOf(context).shortestSide * 0.04,
              fontWeight: FontWeight.bold,
            ),

            //Body Texts
            //Main content text throughout
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.sizeOf(context).shortestSide * 0.035,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.sizeOf(context).shortestSide * 0.025,
            ),
            bodySmall: TextStyle(
              color: Colors.white,
            ),

            //Display
            //Used to highlight important information
            displayLarge: TextStyle(
              color: Colors.white,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
            ),
            displaySmall: TextStyle(
              color: Colors.white,
            ),

            //Button Labels
            //Used within buttons
            labelLarge: TextStyle(
              color: Colors.white,
            ),
            labelMedium: TextStyle(
              color: Colors.white,
            ),
            labelSmall: TextStyle(
              color: Colors.white,
            ),
          ), colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber).copyWith(background: Colors.black)
      ),
      home: const BaseFrame(),
    );
  }
}
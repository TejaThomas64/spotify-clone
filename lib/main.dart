import 'package:flutter/material.dart';
import 'package:spotifyapp/home_page.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
     darkTheme: ThemeData.dark(),
      home: const HomePage()
         
      
    );
  
  }
}

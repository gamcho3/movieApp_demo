import 'package:demo_app/home/home.dart';
import 'package:demo_app/search/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.nanumGothicTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor:
            const Color.fromARGB(255, 231, 231, 231).withOpacity(0.3),
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search),
            label: '검색',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: '내정보',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: [
        const Home(),
        const SearchPage(),
        Container(),
      ][selectedIndex],
    );
  }
}

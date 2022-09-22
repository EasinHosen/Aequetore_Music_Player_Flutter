import 'package:aequatore_music_player/ui/pages/music_home_page.dart';
import 'package:aequatore_music_player/ui/pages/my_audio_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MusicHomePage.routeName,
      routes: {
        MusicHomePage.routeName: (context) => const MusicHomePage(),
        MyAudioList.routeName: (context) => const MyAudioList(),
        // StorageTestPage.routeName: (context) => const StorageTestPage(),
      },
    );
  }
}

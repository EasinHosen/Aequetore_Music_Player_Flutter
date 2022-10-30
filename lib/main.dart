import 'package:aequatore_music_player/providers/song_provider.dart';
import 'package:aequatore_music_player/ui/pages/music_home_page.dart';
import 'package:aequatore_music_player/ui/pages/my_audio_list_page.dart';
import 'package:aequatore_music_player/ui/pages/neu_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SongProvider()..requestPermission(),
    ),
  ], child: const MyApp()));
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
      initialRoute: MyAudioList.routeName,
      routes: {
        MusicHomePage.routeName: (context) => const MusicHomePage(),
        MyAudioList.routeName: (context) => const MyAudioList(),
        NeuTest.routeName: (context) => const NeuTest(),

        // StorageTestPage.routeName: (context) => const StorageTestPage(),
      },
    );
  }
}

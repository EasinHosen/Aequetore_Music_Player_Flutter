import 'package:aequatore_music_player/providers/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'music_home_page.dart';

class MyAudioList extends StatelessWidget {
  const MyAudioList({Key? key}) : super(key: key);
  static const String routeName = '/my_audio_list_page';

  @override
  Widget build(BuildContext context) {
    Provider.of<SongProvider>(context, listen: false).getAllSongs();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Songs'),
      ),
      body: Center(
        child: Consumer<SongProvider>(
          builder: (context, songProvider, _) {
            return songProvider.songListAll.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: songProvider.songListAll.length,
                    itemBuilder: (context, index) {
                      final song = songProvider.songListAll[index];
                      return ListTile(
                        title: Text(song.title),
                        subtitle: Text(song.artist ?? "No Artist"),
                        leading: QueryArtworkWidget(
                          id: song.id,
                          type: ArtworkType.AUDIO,
                        ),
                        // onTap: () => Navigator.pop(context, song),
                        onTap: () {
                          Navigator.pushNamed(context, MusicHomePage.routeName,
                              arguments: song);
                        },
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

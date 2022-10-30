import 'package:aequatore_music_player/providers/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class MusicHomePage extends StatelessWidget {
  const MusicHomePage({Key? key}) : super(key: key);
  static const String routeName = '/music_home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<SongProvider>(
          builder: (context, sp, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                      child: const Icon(Icons.skip_previous, size: 10),
                      onPressed: () {
                        sp.audioPlayer.seekToPrevious();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    NeumorphicButton(
                      child: Icon(
                        sp.audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                        size: 15,
                      ),
                      onPressed: () {
                        sp.audioPlayer.playing
                            ? sp.audioPlayer.pause()
                            : sp.audioPlayer.play();
                        print(sp.audioPlayer.playing);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    NeumorphicButton(
                      child: const Icon(Icons.skip_next, size: 10),
                      onPressed: () {
                        sp.audioPlayer.seekToNext();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

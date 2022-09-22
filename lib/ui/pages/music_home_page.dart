import 'package:aequatore_music_player/ui/pages/my_audio_list.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../widgets/neu_box.dart';

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({Key? key}) : super(key: key);
  static const String routeName = '/music_home_page';

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  @override
  Widget build(BuildContext context) {
    SongModel? song;
    final player = AudioPlayer();
    String path = '';

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // back button and menu button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MyAudioList.routeName)
                          .then((value) {
                        setState(() {
                          song = value as SongModel?;
                          path = song!.data;
                          print(path);
                        });
                      });
                    },
                    child: SizedBox(
                      height: height / 18,
                      width: width / 8,
                      child: const NeuBox(child: Icon(Icons.menu)),
                    ),
                  ),
                  const Text('A E Q U A T O R E'),
                  SizedBox(
                    height: height / 18,
                    width: width / 8,
                    child: const NeuBox(child: Icon(Icons.search)),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // cover art, artist name, song name
              NeuBox(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        song?.uri ?? 'assets/images/music_thumb.png',
                        height: height / 2.3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song?.artist ?? 'Unknown artist',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                song?.title ?? 'Song name',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          // const Icon(
                          //   Icons.favorite,
                          //   color: Colors.red,
                          //   size: 32,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // start time, shuffle button, repeat button, end time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(song?.duration.toString() ?? '0.10'),
                  Icon(Icons.shuffle),
                  Icon(Icons.repeat),
                  Text('4.20')
                ],
              ),

              const SizedBox(height: 30),

              // linear bar
              NeuBox(
                child: LinearPercentIndicator(
                  lineHeight: 5,
                  percent: 0.1,
                  progressColor: Colors.green,
                  backgroundColor: Colors.transparent,
                  curve: Curves.linear,
                  barRadius: const Radius.circular(5),
                ),
              ),

              const SizedBox(height: 30),

              // previous song, pause play, skip next song
              SizedBox(
                height: height / 12,
                child: Row(
                  children: [
                    const Expanded(
                      child: NeuBox(
                          child: Icon(
                        Icons.skip_previous,
                        size: 32,
                      )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap: () {
                            if (path.isNotEmpty) {
                              player.play(DeviceFileSource(path));
                              print(path);
                            } else {
                              print('$path not found');
                            }
                          },
                          onLongPress: () {
                            if (path.isNotEmpty) {
                              player.pause();
                              print(path);
                            } else {
                              print('path not found');
                            }
                          },
                          child: NeuBox(
                              child: player.state.name == 'paused' ||
                                      player.state.name == 'stopped'
                                  ? const Icon(
                                      Icons.play_arrow,
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.pause,
                                      size: 32,
                                    )),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: NeuBox(
                          child: Icon(
                        Icons.skip_next,
                        size: 32,
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

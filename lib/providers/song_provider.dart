import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongProvider extends ChangeNotifier {
  List<SongModel> songListAll = [];
  List<AudioSource> audioSourceList = [];

  final OnAudioQuery _audioQuery = OnAudioQuery();
  AudioPlayer audioPlayer = AudioPlayer();

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      // print('permission st: $permissionStatus');
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
    notifyListeners();
  }

  getAllSongs() async {
    songListAll = await _audioQuery.querySongs();
    print(songListAll.length);
    readySongs();
    notifyListeners();
  }

  readySongs() {
    if (songListAll.isNotEmpty) {
      audioSourceList.clear();
      for (var element in songListAll) {
        final path = element.data.toString();
        audioSourceList.add(AudioSource.uri(Uri.parse(path)));
      }
      audioPlayer
          .setAudioSource(ConcatenatingAudioSource(children: audioSourceList))
          .catchError((e) {
        print(e);
      });
    } else {
      print('No song found');
    }
    print('sourcelist length: ${audioSourceList.length}');
    notifyListeners();
  }
}

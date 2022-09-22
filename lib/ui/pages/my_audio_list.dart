import 'package:aequatore_music_player/ui/widgets/neu_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyAudioList extends StatefulWidget {
  const MyAudioList({Key? key}) : super(key: key);
  static const String routeName = '/my_audio_list';

  @override
  _MyAudioListState createState() => _MyAudioListState();
}

class _MyAudioListState extends State<MyAudioList> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        // Default values:
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          // Loading content
          if (item.data == null)
            return const Center(child: CircularProgressIndicator());

          // When you try "query" without asking for [READ] or [Library] permission
          // the plugin will return a [Empty] list.
          if (item.data!.isEmpty)
            return const Center(child: Text("Nothing found!"));

          // You can use [item.data!] direct or you can create a:
          // List<SongModel> songs = item.data!;
          return ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              final song = item.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: NeuBox(
                  child: ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist ?? "No Artist"),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                    // This Widget will query/load image. Just add the id and type.
                    // You can use/create your own widget/method using [queryArtwork].
                    leading: QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                    ),
                    onTap: () => Navigator.pop(context, song),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

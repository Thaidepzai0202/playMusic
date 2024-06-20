import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internshipmigi/models/music_song.dart';

class AudioMusicRepo {
  Future<List<ModelMusic>> getData(String url) async {
    List<ModelMusic> listMusic = [];

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));

      listMusic = result.map((e) => ModelMusic.fromJson(e)).toList();
      print(listMusic[0].title.toString());
    }
    return listMusic;
  }
}

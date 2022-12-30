import 'package:flutter/material.dart';
import 'package:movie_app/linking/movie_linking.dart';
import 'package:movie_app/models/movie_video_model.dart';

class MovieVideosProvider with ChangeNotifier {
  final MovieLinking _movieLinking;

  MovieVideosProvider(this._movieLinking);

  MovieVideosModel? _videos;
  MovieVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _movieLinking.getVideos(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _videos = null;
        notifyListeners();
        return;
      },
      (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}

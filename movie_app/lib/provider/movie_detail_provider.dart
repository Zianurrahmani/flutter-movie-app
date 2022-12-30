import 'package:flutter/material.dart';
import 'package:movie_app/linking/movie_linking.dart';
import 'package:movie_app/models/movie_detail_model.dart';

class MovieDetailProvider with ChangeNotifier {
  final MovieLinking _movieLinking;

  MovieDetailProvider(this._movieLinking);

  MovieDetailResponse? _movie;
  MovieDetailResponse? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final results = await _movieLinking.getDetail(id: id);
    results.fold((errorMessage) {
      _movie = null;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }, (response) {
      _movie = response;
      notifyListeners();
      return;
    });
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/linking/movie_linking.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDiscoverProvider with ChangeNotifier {
  final MovieLinking _movieLinking;

  MovieDiscoverProvider(this._movieLinking);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieLinking.getDiscover();

    result.fold((errorMessage) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      return;
    }, (response) {
      _movies.clear();
      _movies.addAll(response.results);
      _isLoading = false;
      notifyListeners();
    });
  }
}

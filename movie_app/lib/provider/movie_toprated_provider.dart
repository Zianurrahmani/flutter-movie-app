import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/linking/movie_linking.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieTopRatedProvider with ChangeNotifier {
  final MovieLinking _movieLinking;

  MovieTopRatedProvider(this._movieLinking);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieLinking.getTopRated();

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
      return null;
    });
  }

  void getTopRatedWithPagination(BuildContext context,
      {required PagingController pagingController, required int page}) async {
    final result = await _movieLinking.getTopRated(page: page);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      return;
    }, (response) {
      if (response.results.length < 20) {
        pagingController.appendLastPage(response.results);
      } else {
        pagingController.appendPage(response.results, page + 1);
      }
      return null;
    });
  }
}

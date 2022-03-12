import 'package:dewsol/models/movie_model.dart';
import 'package:flutter/cupertino.dart';

class MovieProvider extends ChangeNotifier {

  ///lst to hold movies
  List<MovieModel> movieList = [];

  ///setting movie list data
  void setMovieData(List<MovieModel> list){
    movieList = list;
    notifyListeners();
  }
}

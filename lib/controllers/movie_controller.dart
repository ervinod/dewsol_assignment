import 'dart:convert' as convert;

import 'package:dewsol/constants/api_constants.dart';
import 'package:dewsol/models/movie_model.dart';
import 'package:dewsol/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MovieController {
  final BuildContext context;
  late final MovieProvider provider;

  MovieController({required this.context}) {
    ///initialise required stuff here
    provider = Provider.of<MovieProvider>(context, listen: false);
  }

  Future<void> getMovieData(
      ValueNotifier<bool> loadingNotifier) async {
    loadingNotifier.value = true;

    var response = await http.get(Uri.parse(ApiConstants.movieList));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      List<dynamic> result = jsonResponse["result"];

      List<MovieModel> movieList =
          List<MovieModel>.from(result.map((i) => MovieModel.fromJson(i)));
      print('Found: ${movieList.length} movies');
      provider.setMovieData(movieList);
    } else {
      print('Request failed with status: ${response.statusCode}.');
     }
    loadingNotifier.value = false;
  }
}

import 'dart:core';

import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = "https://z3bf7cys.api.sanity.io/";
  static const String movieList = baseUrl+"v2021-10-21/data/query/production?query=*%5B_type%20%3D%3D%20'movie'%5D%7B%0A%20%20title%2C%0A%20%20popularity%2C%0A%20%20poster%2C%0A%20%20releaseDate%2C%0A%20%20overview%2C%0A%20%20castMembers%0A%7D";
}
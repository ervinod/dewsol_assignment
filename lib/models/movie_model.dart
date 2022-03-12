import 'package:dewsol/constants/strings.dart';

class MovieModel {
  final String title;
  final String banner;
  final String overview;
  final String releaseDate;
  final double rating;

  MovieModel({
    required this.title,
    required this.banner,
    required this.overview,
    required this.releaseDate,
    required this.rating,
  });

  ///will be used while parsing json response
  factory MovieModel.fromJson(Map<String, dynamic> json) {

    final popularity = json['popularity'].toString();
    return MovieModel(
      title: json['title'] as String,
      banner: generateImageUrl(json['poster']['asset']['_ref'] as String),
      overview: json['overview'][0]['children'][0]['text'] as String,
      releaseDate: json['releaseDate'] as String,
      rating: double.parse(popularity),
    );
  }
}

///get image url from resource id
String generateImageUrl(String resourceId){
  String url = "https://${StringConstants.projectId}.api.sanity.io/images/${StringConstants.projectId}/${StringConstants.datasetName}/";
  String imageExtension = resourceId.substring(resourceId.lastIndexOf("-")+1);
  resourceId = resourceId.substring(resourceId.indexOf("-")+1, resourceId.lastIndexOf("-"));
  url ="$url$resourceId.${imageExtension}";
  print(url);
  return url;
}
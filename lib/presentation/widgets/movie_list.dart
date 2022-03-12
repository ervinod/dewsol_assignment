import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewsol/constants/colors.dart';
import 'package:dewsol/constants/strings.dart';
import 'package:dewsol/models/movie_model.dart';
import 'package:dewsol/utils/screen_util.dart';
import 'package:dewsol/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class MovieList extends StatelessWidget {
  final List<MovieModel> movieList;

  const MovieList({
    Key? key,
    required this.movieList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        key: Key("movieListView"),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        itemCount: movieList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return MovieItem(
            key: Key('movieItem$index'),
            model: movieList[index],
          );
        },
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  final MovieModel model;

  const MovieItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, model);
      },
      child: Container(
        width: getWidth(context),
        decoration: BoxDecoration(
          color: ColorsBase.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorsBase.darkBlack.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: CachedNetworkImage(
                  width: 90,
                  height: 90,
                  imageUrl: model.banner,
                  fit: BoxFit.cover,
                  key: const Key('movieImageContainer'),
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: ColorsBase.light200Grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    height: 90,
                    width: getWidth(context),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: ColorsBase.light200Grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    height: 90,
                    width: getWidth(context),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16) as double,
                      color: ColorsBase.darkGucci,
                      fontFamily: StringConstants.fontRobotoRegular,
                      height: 1.2,
                    ),
                    key: const Key('movieName'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        itemPadding: EdgeInsets.zero,
                        rating: model.rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: ColorsBase.green,
                        ),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        model.rating.toString(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(13) as double,
                          color: ColorsBase.darkBlack.withOpacity(0.4),
                          height: 1.2,
                        ),
                        key: const Key('rating'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDetailsDialog(BuildContext context, MovieModel model) async {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: getHeight(context) * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        model.title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.clear))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: CachedNetworkImage(
                      width: getWidth(context),
                      imageUrl: model.banner,
                      fit: BoxFit.cover,
                      key: const Key('movieImage'),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: ColorsBase.light200Grey,
                        ),
                        width: getWidth(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: ColorsBase.darkBlack.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(model.releaseDate)),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: ColorsBase.darkBlack.withOpacity(0.6),
                        ),
                      ),
                      const Spacer(),
                      RatingBarIndicator(
                        itemPadding: EdgeInsets.zero,
                        rating: model.rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: ColorsBase.green,
                        ),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        model.rating.toString(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(13) as double,
                          color: ColorsBase.darkBlack.withOpacity(0.4),
                          height: 1.2,
                        ),
                        key: const Key('rating'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    model.overview,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorsBase.darkBlack.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
      });
}

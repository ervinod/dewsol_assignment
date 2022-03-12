import 'package:dewsol/constants/colors.dart';
import 'package:dewsol/constants/strings.dart';
import 'package:dewsol/controllers/recommendation_controller.dart';
import 'package:dewsol/presentation/skeletons/movie_list_skeleton.dart';
import 'package:dewsol/presentation/widgets/movie_list.dart';
import 'package:dewsol/providers/movie_provider.dart';
import 'package:dewsol/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late final RecommendationController _controller;
  late final MovieProvider _recommendationProvider;
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);

  //declaring node to manage text field focus
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    _controller = RecommendationController(context: context);
    _recommendationProvider =
        Provider.of<MovieProvider>(context, listen: false);

    ///getting movie list data
    _controller.getRecommendationData(loadingNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///initializing screenutil to get screen dimension
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);

    return SafeArea(
      child: Scaffold(
        key: const Key('scaffold'),
        backgroundColor: ColorsBase.backGroundColor,
        body: Column(
          key: const Key('mainColumn'),
          children: [
            CustomAppBar(_searchFocus, height: 120),
            ValueListenableBuilder(
              valueListenable: loadingNotifier,
              builder: (context, bool loading, child) {
                if (loading) {
                  ///show loading skeleton
                  return Expanded(
                    child: MovieListSkeleton(
                      key: const Key('loadingSkeleton'),
                    ),
                  );
                }

                ///show horizontal listview
                return MovieList(
                  key: const Key('movieList'),
                  movieList: _recommendationProvider.movieList,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//creating custom actionbar with search functionality
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final FocusNode searchFocus;

  const CustomAppBar(this.searchFocus, {Key? key, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: ColorsBase.darkGucci,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              child: Row(children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    //handle click on icon
                  },
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TextField(
                      focusNode: searchFocus,
                      decoration: InputDecoration.collapsed(
                        hintText: StringConstants.searchMovie,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchFocus.unfocus();
                  },
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

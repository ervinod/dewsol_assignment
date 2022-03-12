import 'package:flutter/material.dart';
import 'package:dewsol/constants/colors.dart';
import 'package:dewsol/utils/utility.dart';
import 'package:shimmer/shimmer.dart';

class MovieListSkeleton extends StatelessWidget {
  final double? height;
  final double radius;

  const MovieListSkeleton({
    Key? key,
    this.height = 0.10,
    this.radius = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
      key: const Key('progressShimmer'),
      baseColor: ColorsBase.light300Grey,
      highlightColor: ColorsBase.light100Grey,
      child: ListView.separated(
        key: Key("recommendationListView"),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CommonSkeletonContainer(1, height!, 14);
        },
      ),
    );
  }
}

class CommonSkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const CommonSkeletonContainer(this.width, this.height, this.radius);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context) * width,
      height: getHeight(context) * height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: ColorsBase.white,
      ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news/model/newsModel.dart';
import 'package:news/utils/constants.dart';

class FutureNewsCarousel extends StatefulWidget {
  const FutureNewsCarousel({
    super.key,
    required Future<List<Articles>?> newsData,
  }) : _newsData = newsData;

  final Future<List<Articles>?> _newsData;

  @override
  State<FutureNewsCarousel> createState() => _FutureNewsCarouselState();
}

class _FutureNewsCarouselState extends State<FutureNewsCarousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articles>?>(
      future: widget._newsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          bool isError = false;

          return PageView.builder(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final article = snapshot.data![index];

              if (article.title != "[Removed]") {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(22.r)),
                        child: CachedNetworkImage(
                          fadeOutCurve: Curves.fastEaseInToSlowEaseOut,
                          placeholder: (context, url) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/logo.png")),
                          errorWidget: (context, url, error) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/logo.png")),
                          imageUrl: article.urlToImage,
                          height: double.maxFinite,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 10.h, left: 8.w, right: 8.w),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(22.r)),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black45,
                                    AppColors.blackColor
                                  ],
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: montserratTextStyle(
                                      AppColors.whiteColor,
                                      12.sp,
                                      FontWeight.w900),
                                ),
                                Gap(2.h),
                                Row(
                                  children: [
                                    Text(
                                      article.source.name,
                                      style: montserratTextStyle(
                                          AppColors.whiteColor,
                                          11.sp,
                                          FontWeight.w600),
                                    ),
                                    Gap(5.w),
                                    Text(
                                      DateFormat('EEEE, MMMM dd')
                                          .format(article.publishedAt),
                                      style: montserratTextStyle(
                                          AppColors.whiteColor,
                                          11.sp,
                                          FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

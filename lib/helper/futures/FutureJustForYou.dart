
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news/model/newsModel.dart';
import 'package:news/utils/constants.dart';

class FutureJustForYou extends StatelessWidget {
  const FutureJustForYou({
    super.key,
    required Future<List<Articles>?> newsData,
  }) : _newsData = newsData;

  final Future<List<Articles>?> _newsData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articles>?>(
      future: _newsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final article = snapshot.data![index];
              if (article.title != "[Removed]") {
                return Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.fromLTRB(0, 6.h, 0, 6.h),
                  decoration: BoxDecoration( borderRadius:
                                  BorderRadius.all(Radius.circular(22.r)),
                    border: Border.all(width: 0.2.w,color: AppColors.secondaryBackgroundColor),
                  ),
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                article.title,
                                style: montserratTextStyle(AppColors.blackColor,
                                    13.sp, FontWeight.w800),
                              ),
                              Gap(2.h),
                              Row(
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    "Source: ${article.source.name}",
                                    style: montserratTextStyle(
                                        AppColors.greyColor,
                                        12.sp,
                                        FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                "Published On ${DateFormat('EEEE, MMMM dd').format(article.publishedAt)}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: montserratTextStyle(AppColors.greyColor,
                                    11.sp, FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.3,
                                  color: AppColors.secondaryBackgroundColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.r))),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.r)),
                            child: CachedNetworkImage(
                              fadeOutCurve: Curves.ease,
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
                        ),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news/helper/helper.dart';
import 'package:news/model/newsModel.dart';
import 'package:news/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Articles>?> _newsData;

  @override
  void initState() {
    super.initState();
    _newsData = Helper().getNewsData();
  }

  int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      right: false,
      left: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(0.w, 12.h, 0.w, 0.h),
        //   decoration: BoxDecoration(border: Border.all(width: 1.w)),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.blackColor,
                        radius: 6.5.r,
                      ),
                      Gap(5.w),
                      Text(
                        "Bulletin News",
                        style: montserratTextStyle(
                            Colors.black, 14.sp, FontWeight.w700),
                      )
                    ],
                  ),
                  CircleAvatar(
                    child: const Icon(Octicons.person),
                    backgroundColor: Colors.brown.shade100,
                    radius: 16.dm,
                  ),
                ],
              ),
            ),
            Gap(16.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateToday(),
                    style: montserratTextStyle(
                        AppColors.greyColor, 10.5.sp, FontWeight.w600),
                  ),
                  Gap(2.h),
                  Text(
                    "Welcome back,\nJeniffer",
                    style: montserratTextStyle(
                        AppColors.blackColor, 22.sp, FontWeight.w700),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: customTab()),
            Gap(16.h),
            SizedBox(
              height: 180.h,
              child: FutureNewsCarousel(newsData: _newsData),
            ),
            Gap(16.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Just For You",
                    style: montserratTextStyle(
                        AppColors.blackColor, 16.sp, FontWeight.bold),
                  ),
                  Text(
                    "See More",
                    style: montserratTextStyle(
                        AppColors.linkColor, 12.sp, FontWeight.bold),
                  ),
                ],
              ),
            ),
            Gap(10.h),
            FutureJustForYou(newsData: _newsData)
          ],
        ),
      ),
    );
  }

  Padding customTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            color: AppColors.secondaryBackgroundColor,
            // border: Border.all(width: 1.w),
          ),
          child: Builder(builder: (context) {
            List tabNames = ["Feeds", "Popluar", "Saved"];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                tabNames.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      curIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: curIndex == index
                          ? AppColors.whiteColor
                          : Colors.white24,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    curve: Curves.linear.flipped,
                    duration: curIndex == index
                        ? const Duration(milliseconds: 500)
                        : const Duration(seconds: 0),
                    child: Text(
                      tabNames[index],
                      style: montserratTextStyle(
                          Colors.black, 11.sp, FontWeight.normal),
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}

class FutureNewsCarousel extends StatelessWidget {
  const FutureNewsCarousel({
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
          return PageView.builder(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final article = snapshot.data![index];
              if (article.title != "[Removed]") {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.w),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        image: NetworkImage(article.urlToImage)),
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    // border: Border.all(width: 1.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 10.h, left: 8.w, right: 8.w),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r)),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black45, AppColors.blackColor],
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: montserratTextStyle(
                                  AppColors.whiteColor, 12.sp, FontWeight.w900),
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
                  margin: EdgeInsets.fromLTRB(0, 4.h, 0, 4.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [],
                      ),
                      Container(
                        height: 80.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            image: DecorationImage(
                                image: NetworkImage(article.urlToImage),
                                fit: BoxFit.cover)),
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

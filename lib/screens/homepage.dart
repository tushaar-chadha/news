import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news/helper/futures/FutureCarousel.dart';
import 'package:news/helper/futures/FutureJustForYou.dart';
import 'package:news/helper/helper.dart';
import 'package:news/model/newsModel.dart';
import 'package:news/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Articles>?> _newsData, _justForYou;

  @override
  void initState() {
    super.initState();
    _newsData = Helper().getNewsData();
    _justForYou = Helper().getNewsJustForYou([
      "Business",
      "Entertainment",
      "General",
      "Health",
      "Science",
      "Sports",
      "Technology"
    ]);
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
            FutureJustForYou(newsData: _justForYou)
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

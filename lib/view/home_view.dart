import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/category_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/course_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/course_card.dart';
import 'package:size_config/util/size_extention.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: appBarStyle,
        title: Consumer<UserVM>(builder: (context, provider, _) {
          final User user = provider.response.data;
          return Text('Hai, ${user.data.username}👋');
        }),
      ),
      body: Consumer<CourseVM>(builder: (context, provider, _) {
        List<Course> courses = provider.filter;
        return ListView(
          padding: EdgeInsets.only(
            left: margin,
            right: margin,
            bottom: 16.h,
          ),
          children: [
            SizedBox(height: 20.h),
            Text('Kategori', style: titleStyle),
            SizedBox(height: 12.h),
            // ? Kategori
            SizedBox(
              height: 125.h,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(2.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  crossAxisCount: 2,
                  childAspectRatio:
                      MediaQuery.of(context).size.aspectRatio * 6.2,
                ),
                itemCount: 4,
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () => provider.categoryClicked(categories[i]),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          categories[i].isClicked ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: cardShadow,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 36.h,
                          width: 36.w,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: categories[i].isClicked
                                ? Colors.white
                                : primaryColor,
                          ),
                          child: SvgPicture.asset(
                            categories[i].isClicked
                                ? activePath[i]
                                : inactivePath[i],
                          ),
                        ),
                        Text(
                          categories[i].title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight:
                                categories[i].isClicked ? semiBold : normal,
                            color: categories[i].isClicked
                                ? Colors.white
                                : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('Kelas Terbaru', style: titleStyle),
            SizedBox(height: 12.h),
            courses.isEmpty
                ? missingIllustration(MediaQuery.of(context).size.height / 2.2)
                : GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(2),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      crossAxisCount: 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio *
                              1.55, //0.745
                    ),
                    itemCount: courses.length >= 4 ? 4 : courses.length,
                    itemBuilder: (_, i) => CourseCard(courses[i]),
                  ),
          ],
        );
      }),
    );
  }
}

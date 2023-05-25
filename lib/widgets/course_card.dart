import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/view_model/course_vm.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
import '../common/styles.dart';
import '../data/model/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard(
    this.course, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseP = Provider.of<CourseVM>(context);

    return GestureDetector(
      onTap: () {
        if (courseP.userCourses.contains(course)) {
          Navigation.intentWithData('/course_detail', course);
        } else {
          Navigation.intentWithData('/detail', course);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(course.photoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              course.name,
              style: TextStyle(fontWeight: semiBold, fontSize: 14.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              course.mentor.name,
              style: TextStyle(
                fontSize: 12.sp,
                color: secondaryTextColor,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              course.price == 0 ? "Free" : rupiahFormating(course.price),
              style: TextStyle(
                fontWeight: semiBold,
                color: primaryColor,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

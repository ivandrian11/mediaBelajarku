import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/model/project.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/course_vm.dart';
import 'package:media_belajarku/view_model/project_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
// import 'package:media_belajarku/widgets/progress_bar.dart';

class ClassView extends StatefulWidget {
  const ClassView({Key? key}) : super(key: key);

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  @override
  void initState() {
    Future.microtask(() {
      User user = Provider.of<UserVM>(context, listen: false).response.data;

      final projectP = Provider.of<ProjectVM>(context, listen: false);
      projectP.fetchAllProject(user.data.username);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelas Saya 📚'),
        titleTextStyle: appBarStyle,
      ),
      body: Consumer<ProjectVM>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<Course> courses =
                Provider.of<CourseVM>(context, listen: false).userCourses;
            List<Course> completedCourse = [];
            List<Project> projects = provider.projects;

            if (projects.isNotEmpty) {
              List<Project> helper = [];
              helper.addAll(projects);
              helper.retainWhere((element) => element.score >= 80);
              if (helper.isNotEmpty) {
                final projectsId = helper.map((e) => e.course);
                for (var course in courses) {
                  if (projectsId.contains(course.id)) {
                    completedCourse.add(course);
                  }
                }
              }
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: courses.isEmpty
                  ? emptyIllustrationCourse(
                      MediaQuery.of(context).size.height / 1.5)
                  : DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xffDBE1F1)),
                              ),
                            ),
                            child: TabBar(
                              indicatorColor: primaryColor,
                              labelColor: primaryColor,
                              unselectedLabelColor: secondaryTextColor,
                              tabs: [
                                Tab(text: 'Kelas Saya'),
                                Tab(text: 'Selesai'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ListView(
                                    padding: EdgeInsets.all(2.w),
                                    children: courses
                                        .map((e) => ClassContainer(
                                              course: e,
                                              // percentage: 0.80,
                                            ))
                                        .toList()),
                                completedCourse.isEmpty
                                    ? Center()
                                    : ListView(
                                        padding: EdgeInsets.all(2.w),
                                        children: completedCourse
                                            .map((e) => ClassContainer(
                                                  course: e,
                                                  // percentage: 0.80,
                                                ))
                                            .toList()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          }
        },
      ),
    );
  }
}

class ClassContainer extends StatelessWidget {
  const ClassContainer({
    required this.course,
    // required this.percentage,
    Key? key,
  }) : super(key: key);

  final Course course;
  // final double percentage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.intentWithData('/course_detail', course),
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: cardShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  course.photoUrl,
                  fit: BoxFit.cover,
                  height: 115.h,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: TextStyle(fontWeight: semiBold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    course.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: secondaryTextColor,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(height: 12),
                  // ProgressBar(percentage: percentage, height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

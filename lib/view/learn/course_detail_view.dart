import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/api/api_response.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/data/model/materials.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/materials_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
// import 'package:media_belajarku/widgets/progress_bar.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:provider/provider.dart';

class CourseDetailView extends StatefulWidget {
  final Course course;

  const CourseDetailView(this.course, {Key? key}) : super(key: key);

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  late User user;

  @override
  void initState() {
    Future.microtask(() {
      user = Provider.of<UserVM>(context, listen: false).response.data;

      final materialP = Provider.of<MaterialsVM>(context, listen: false);
      materialP.fetchDetails(widget.course.id, user.data.username);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Consumer<MaterialsVM>(
        builder: (context, provider, _) {
          switch (provider.response.status) {
            case Status.initial:
              return Center(
                child: Text(
                  'Fetching data...',
                  style: TextStyle(color: Colors.white),
                ),
              );
            case Status.loading:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Color(0xffB1BBD4),
                ),
              );
            case Status.error:
              return Center(
                child: Text(
                  provider.response.message!,
                  style: standardStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            case Status.completed:
              final List<Materials> materials = provider.response.data;
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child:
                        Image.asset('assets/img/top-corner.png', width: 135.h),
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigation.back(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // ? Bagian Atas
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: margin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.course.name,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: semiBold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                widget.course.description,
                                style:
                                    TextStyle(color: Colors.white, height: 1.6),
                              ),
                              SizedBox(height: 12.h),
                              RichText(
                                text: TextSpan(
                                  text: 'Dibuat oleh ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.course.mentor.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 16),
                              // ProgressBar(
                              //   percentage: 0.8,
                              //   height: 10,
                              //   backgroundColor: Color(0xffB1BBD4),
                              //   valueColor: Colors.white,
                              //   labelColor: Colors.white,
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // ? Bagian Bawah
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: margin),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30.h),
                                CourseOption(
                                  onTap: () => Navigation.intentWithData(
                                    '/material',
                                    widget.course,
                                  ),
                                  icon: Icons.notes,
                                  title: '${materials.length} Materi',
                                  subtitle: 'Pelajari fundamentalnya',
                                ),
                                Divider(color: Color(0xffE7E7E7), thickness: 1),
                                CourseOption(
                                  onTap: () {
                                    if (widget.course.projectInstruction ==
                                        "-") {
                                      showErrorMessage(
                                          "This course doesnt have project.");
                                    } else {
                                      Navigation.intentWithData(
                                        '/project',
                                        widget.course,
                                      );
                                    }
                                  },
                                  icon: Icons.folder,
                                  title: 'Proyek',
                                  subtitle: 'Implementasikan materi',
                                ),
                                Divider(color: Color(0xffE7E7E7), thickness: 1),
                                CourseOption(
                                  onTap: () {
                                    if (widget.course.projectInstruction ==
                                        "-") {
                                      showErrorMessage(
                                          "This course doesnt have certificate.");
                                    } else if (provider.project == null) {
                                      showErrorMessage(
                                          "You must complete the project first.");
                                    } else {
                                      if (provider.project!.score == 0) {
                                        showErrorMessage(
                                            "Your submitted project will be reviewed first.");
                                      } else {
                                        final helper = materials
                                            .map((e) => e.title)
                                            .toList();
                                        helper[helper.length - 1] =
                                            "and ${helper.last}";

                                        final data = {
                                          "name": user.data.name,
                                          "course": widget.course.name,
                                          "description":
                                              "You have studied and applied learning materials such as ${helper.join(", ")}.",
                                        };

                                        Navigation.intentWithData(
                                          '/certificate',
                                          data,
                                        );
                                      }
                                    }
                                  },
                                  icon: Icons.military_tech,
                                  title: 'Sertifikat Kelulusan',
                                  subtitle: 'Bukti menyelesaikan kelas',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class CourseOption extends StatelessWidget {
  const CourseOption({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  final Function()? onTap;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Color(0xffDBE1F1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: primaryColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: primaryColor,
          fontWeight: semiBold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: secondaryTextColor, fontSize: 14.sp),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 24.h),
    );
  }
}

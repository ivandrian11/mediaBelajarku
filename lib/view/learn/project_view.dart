import 'package:flutter/material.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/api/api_response.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/data/model/project.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/project_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';

class ProjectView extends StatefulWidget {
  final Course course;

  const ProjectView(this.course, {Key? key}) : super(key: key);

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  late User user;
  final urlC = TextEditingController();

  @override
  void dispose() {
    urlC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.microtask(() {
      user = Provider.of<UserVM>(context, listen: false).response.data;

      final projectP = Provider.of<ProjectVM>(context, listen: false);
      projectP.getProjectUser(user.data.username, widget.course.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
        titleTextStyle: appBarStyle,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Consumer<ProjectVM>(
          builder: (context, provider, _) {
            switch (provider.response.status) {
              case Status.initial:
                return Center(
                  child: Text('Fetching data...', style: standardStyle),
                );
              case Status.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                return Center(
                  child: Text(
                    provider.response.message!,
                    style: standardStyle,
                    textAlign: TextAlign.center,
                  ),
                );
              case Status.completed:
                Project? project = provider.response.data;
                if (project != null) urlC.text = project.url;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text('Proyek', style: subtitleStyle),
                    SizedBox(height: 12.h),
                    Text(
                      widget.course.projectInstruction,
                      style: standardStyle,
                    ),
                    SizedBox(height: 20.h),

                    // ? Button
                    SizedBox(
                      height: 45.h,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: TextField(
                              controller: urlC,
                              autocorrect: false,
                              style: standardStyle,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                                hintText: 'Masukkan link pengerjaan',
                                hintStyle: standardStyle,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Flexible(
                            child: ReusableButton(
                              style: buttonStyle,
                              isLoading: provider.isLoading,
                              text: 'Kirim',
                              onPressed: () {
                                if (urlC.text.isEmpty) {
                                  showErrorMessage(
                                      "Input field must not be empty");
                                } else {
                                  if (project == null) {
                                    provider
                                        .sendProjectUser(
                                          user.data.username,
                                          widget.course.id,
                                          urlC.text,
                                        )
                                        .then((value) => showSuccessMessage(
                                            "Your task has been saved."));
                                  } else {
                                    provider
                                        .updateProjectUser(
                                          project.id,
                                          urlC.text,
                                        )
                                        .then((value) => showSuccessMessage(
                                            "Your task has been updated."));
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ? Feedback
                    project == null || project.feedback == ""
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),
                              Text('Feedback', style: subtitleStyle),
                              SizedBox(height: 12.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  border: Border.all(),
                                ),
                                child: Text(
                                  project.feedback,
                                  style: standardStyle,
                                ),
                              ),
                            ],
                          )
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

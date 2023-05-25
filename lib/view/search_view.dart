import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/view_model/course_vm.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/widgets/course_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchC = TextEditingController();

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Course 🔎'),
        titleTextStyle: appBarStyle,
      ),
      body: Consumer<CourseVM>(
        builder: (context, provider, _) {
          List<Course> result = provider.result;

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: margin),
            children: [
              SizedBox(height: 24.h),
              TextField(
                controller: searchC,
                onSubmitted: (keyword) => provider.searchCourse(keyword),
                autocorrect: false,
                style: standardStyle,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  hintText: 'Masukkan kata kunci',
                  hintStyle: standardStyle,
                  suffixIcon: Icon(Icons.search, size: 24.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              result.isEmpty
                  ? missingIllustration(MediaQuery.of(context).size.height / 2)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hasil Pencarian', style: subtitleStyle),
                        SizedBox(height: 12.h),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(2.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.aspectRatio * 1.55,
                          ),
                          itemCount: result.length,
                          itemBuilder: (_, i) => CourseCard(result[i]),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}

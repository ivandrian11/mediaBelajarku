import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/data/api/api_response.dart';
import 'package:media_belajarku/view_model/helper_vm.dart';
import 'package:media_belajarku/view_model/course_vm.dart';
import 'package:media_belajarku/view/home_view.dart';
import 'package:media_belajarku/view/search_view.dart';
import 'package:media_belajarku/view/learn/class_view.dart';
import 'package:media_belajarku/view/profile/profile_view.dart';
import 'package:media_belajarku/common/styles.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    Future.microtask(() {
      User user = Provider.of<UserVM>(context, listen: false).response.data;
      final courseP = Provider.of<CourseVM>(context, listen: false);
      courseP.fetchAllCourse(user.data.username);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final helperP = Provider.of<HelperVM>(context);

    final _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(_bottomNavIndex == 0 ? Icons.home : Icons.home_outlined),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(_bottomNavIndex == 1 ? Icons.school : Icons.school_outlined),
        label: 'Kelas',
      ),
      BottomNavigationBarItem(
        icon: Icon(_bottomNavIndex == 2 ? Icons.search : Icons.search_outlined),
        label: 'Cari',
      ),
      BottomNavigationBarItem(
        icon: Icon(_bottomNavIndex == 3 ? Icons.person : Icons.person_outlined),
        label: 'Profil',
      ),
    ];

    final _pages = [
      HomeView(),
      ClassView(),
      SearchView(),
      ProfileView(),
    ];

    return RefreshIndicator(
      onRefresh: () async {
        Navigation.offAll('/main');
      },
      child: Scaffold(
        bottomNavigationBar: helperP.isLoading
            ? SizedBox()
            : Container(
                decoration: BoxDecoration(boxShadow: bottomShadow),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  currentIndex: _bottomNavIndex,
                  items: _bottomNavBarItems,
                  onTap: (index) {
                    setState(() => _bottomNavIndex = index);
                  },
                ),
              ),
        body: Consumer<CourseVM>(
          builder: (context, provider, _) {
            switch (provider.response.status) {
              case Status.initial:
                return Center(
                  child: Text('Fetching data...', style: standardStyle),
                );
              case Status.loading:
                return Center(child: CircularProgressIndicator());
              case Status.error:
                return Center(
                  child: Text(
                    provider.response.message!,
                    style: standardStyle,
                    textAlign: TextAlign.center,
                  ),
                );
              case Status.completed:
                Timer(Duration(milliseconds: 500), () => helperP.stopLoading());

                return _pages[_bottomNavIndex];
            }
          },
        ),
      ),
    );
  }
}

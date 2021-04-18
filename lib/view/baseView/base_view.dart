import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sakla/view/baseView/home_view.dart';
import 'package:sakla/view/baseView/my_profile.dart';
import 'package:sakla/view/baseView/photo_view.dart';
import 'package:sakla/view/baseView/video_view.dart';

class BaseView extends StatefulWidget {
  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  var _selectedTab = _SelectedTab.home;
  void _handleIndexChanged(int i) {
    setState(() {
      pageController.jumpToPage(i);
      _selectedTab = _SelectedTab.values[i];
    });
  }

  late HomeView homeView;
  late PhotoView photoView;
  late VideoView videoView;
  late MyProfile myProfile;
  late List<Widget> allPage;

  late PageController pageController;

  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    homeView = HomeView();
    photoView = PhotoView();
    videoView = VideoView();
    myProfile = MyProfile();
    allPage = [homeView, photoView, videoView, myProfile];
    pageController = PageController();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DotNavigationBar(
        
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTap: _handleIndexChanged,
        selectedItemColor: Color(0xff1C1E3D),
        unselectedItemColor: Colors.blueGrey,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(Icons.home),
          ),

          /// Photo
          DotNavigationBarItem(
            icon: Icon(Icons.photo),
          ),

          /// Video
          DotNavigationBarItem(
            icon: Icon(Icons.video_collection),
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            selectedIndex = index;
            _handleIndexChanged(index);
          });
        },
        children: allPage,
      ),
    );
  }
}

enum _SelectedTab { home, photo, video, myProfile }
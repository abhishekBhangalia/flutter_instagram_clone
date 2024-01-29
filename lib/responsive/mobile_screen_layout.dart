import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
// import 'package:instagram_clone/Providers/UserProvider.dart';
// import 'package:provider/provider.dart';

// import '../models/User.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  _onBottomNavTapped(int page){
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    // model.User _user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: bottomNavBarItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: _onBottomNavTapped,
        backgroundColor: mobileBackgroundColor,
        items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _page == 0 ? primaryColor : secondaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: _page == 1 ? primaryColor : secondaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle,
            color: _page == 2 ? primaryColor : secondaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: _page == 3 ? primaryColor : secondaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: _page == 4 ? primaryColor : secondaryColor,
          ),
        ),
        
      ]),
    );
  }
}

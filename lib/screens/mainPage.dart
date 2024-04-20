import 'package:flutter/material.dart';
import 'package:news/screens/homepage.dart';
import 'package:news/utils/constants.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class mainPage extends StatefulWidget {
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List<Widget> pagesToBeDisplayed = [
    MyHomePage(),
    Text(""),
    Text(""),
    Text("")
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          enableFeedback: true,
          items: [
            bottomNavBarItem(MaterialCommunityIcons.home_outline,
                MaterialCommunityIcons.home),
            bottomNavBarItem(MaterialCommunityIcons.compass_outline,
                MaterialCommunityIcons.compass),
            bottomNavBarItem(MaterialCommunityIcons.folder_heart_outline,
                MaterialCommunityIcons.folder_heart),
            bottomNavBarItem(Ionicons.person_outline, Ionicons.person),
          ],
          selectedItemColor: AppColors.blackColor,
          unselectedItemColor: Colors.grey.shade500,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          showUnselectedLabels: false,
          elevation: 20,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      body: pagesToBeDisplayed[currentIndex],
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(IconData icon, IconData ActiveIcon) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Icon(
        icon,
        size: 28,
      ),
    ),
    label: "",
    activeIcon: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Icon(
        ActiveIcon,
        size: 30,
      ),
    ),
  );
}

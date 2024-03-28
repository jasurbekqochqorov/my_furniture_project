import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/tabs/profile/profile_screen.dart';
import 'package:my_furniture_project/screens/tabs/shopping/shopping_screen.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';
import '../../view_models/tab_view_model.dart';
import 'categories/categories_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [
    const CategoriesScreen(),
    const ShoppingScreen(),
    const ProfileScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (newIndex) {
          context.read<TabViewModel>().changeIndex(newIndex);
        },
        selectedItemColor:AppColors.c_0C8A7B,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
            activeIcon: Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Shopping",
            activeIcon: Icon(
              Icons.shopping_basket,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            activeIcon: Icon(
              Icons.person,
            ),
          )
        ],
      ),
    );
  }
}

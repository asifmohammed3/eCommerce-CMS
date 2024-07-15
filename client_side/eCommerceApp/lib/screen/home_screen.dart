import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '../../../utility/app_data.dart';
import '../../../widget/page_wrapper.dart';
import 'product_cart_screen/cart_screen.dart';
import 'product_favorite_screen/favorite_screen.dart';
import 'product_list_screen/product_list_screen.dart';
import 'profile_screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  static const List<Widget> screens = [
    ProductListScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: HomeScreen.screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: AppData.bottomNavyBarItems
              .map(
                (item) => BottomNavigationBarItem(
                  icon: item.icon,
                  label: item.title,
                ),
              )
              .toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

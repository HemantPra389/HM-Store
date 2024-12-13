import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hm_store/core/icon_string.dart';
import 'package:hm_store/feature/main_app/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:hm_store/feature/main_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:hm_store/feature/main_app/presentation/screens/cart/cart_screen.dart';
import 'package:hm_store/feature/main_app/presentation/screens/category/category_screen.dart';
import 'package:hm_store/feature/main_app/presentation/screens/favourite/favourite_screen.dart';
import 'package:hm_store/feature/main_app/presentation/screens/category/productlist_screen.dart';

import 'home/home_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  final icons = [
    TIconString.home,
    TIconString.category,
    TIconString.add,
    TIconString.favourite,
    TIconString.cart,
  ];
  final List<Widget> bottomBarItems = [
    HomeScreen(),
    BlocProvider(
        create: (context) => CategoryBloc()..add(FetchCategoryEvent()),child: CategoryScreen(),),
    SizedBox(),
    FavouriteScreen(),
    CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomBarItems[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: List.generate(icons.length, (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icons[index],
              height: 28,
              color: _selectedIndex == index ? Colors.black : Colors.black54,
            ),
            label: "",
          );
        }),
      ),
    );
  }
}

import 'package:firebase_provider/mini_screens/wishlist_screen.dart';
import 'package:firebase_provider/widgets/my_drawer.dart';
import 'package:firebase_provider/widgets/dummy_search_bar.dart';
import 'package:firebase_provider/widgets/products_list_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_provider/main_screens/profile_screen.dart';
import 'package:firebase_provider/main_screens/categories_screen.dart';
import 'package:firebase_provider/mini_screens/cart_screen.dart';
import 'package:firebase_provider/widgets/category_home_widget.dart';
import 'package:firebase_provider/main_screens/electronics_screen.dart';
import 'package:firebase_provider/main_screens/fruits_screen.dart';
import 'package:firebase_provider/widgets/home_main_categories.dart';
import 'package:firebase_provider/widgets/home_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(child: MyDrawer()),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Column(
            children: [
              MyAppBar(
                title: 'Welcome',
                leadingIcon: const Icon(Icons.menu),
                onLeadingIconPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                actionIcon: const Icon(Icons.favorite),
                onActionIconPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const WishlistScreen()),
                  );
                },
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      DummySearchBar(),
                      SizedBox(height: 10),
                      MyHomeSliderWidget(),
                      SizedBox(height: 10),
                      MainCategories(
                        nextScreen: CategoriesScreen(
                          fromHome: false,
                        ),
                        category: 'Categories',
                        headline: 'Choose for your better life.',
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      CategoryWidget(
                        title: 'Hot Deals',
                        subtitle: 'Upto 30% off',
                        category: 'Fruits',
                        nextScreen: FruitsScreen(),
                      ),
                      SizedBox(height: 10),
                      CategoryWidget(
                        title: 'Branded Products',
                        subtitle: 'Original and branded',
                        category: 'Electronics',
                        nextScreen: ElectronicsScreen(),
                      ),
                      SizedBox(height: 10),
                      ProductsListHome()
                    ],
                  ),
                ),
              ),
            ],
          ),
          const CategoriesScreen(
            fromHome: true,
          ),
          const CartScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.orange,
        backgroundColor: Colors.transparent,
        items: const [
          Icon(Icons.home, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
        ],
        index: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 01),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}

import 'package:ecommerce_app/add_cart.dart';
import 'package:ecommerce_app/buy_product.dart';
import 'package:ecommerce_app/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class homepage extends StatelessWidget {
  homepage({super.key});

  List<Widget> pages = [buy_product(), add_cart(), profile_page()];
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            rippleColor: Colors.grey,
            // tab button ripple color when pressed
            hoverColor: Colors.grey,
            // tab button hover color
            haptic: true,
            // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            // tab button border
            tabBorder: Border.all(color: Colors.grey, width: 1),
            // tab button border
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            ],
            // tab button shadow
            curve: Curves.easeOutExpo,
            // tab animation curves
            duration: Duration(milliseconds: 100),
            // tab animation duration
            gap: 8,
            // the tab button gap between icon and text
            color: Colors.grey[800],
            // unselected icon color
            activeColor: Colors.purple,
            // selected icon and text color
            iconSize: 24,
            // tab button icon size
            tabBackgroundColor: Colors.purple.withOpacity(0.1),
            // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            // navigation bar padding
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.add_shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ],
            onTabChange: (value) {
              selectedIndex.value = value;
            },
          ),
        ),
        body: Obx(() => pages[selectedIndex.value]));
  }
}

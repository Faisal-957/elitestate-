import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/view/home/home.dart';
import 'package:elitestate/view/profile_screen/profile_screen.dart';
import 'package:elitestate/view/savescreen/addproperty.dart';
import 'package:elitestate/view_model/bottombar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final List<Widget> pages = [Home(), Addproperty(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          body: pages[vm.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: golden,
            unselectedItemColor: Colors.grey,
            currentIndex: vm.currentIndex,

            onTap: (index) {
              vm.changeIndex(index);
            },

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Add Property",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}

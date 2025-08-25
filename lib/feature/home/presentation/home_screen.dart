import 'package:flutter/material.dart';
import 'package:vivu_mobile/core/common/widget/nav_bar/bottom_bar_screen.dart';

import '../../../core/common/constants/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MAIN_LINEAR_TOP,
      ),
      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 30),
      width: double.infinity,

      height: double.infinity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search,color: Colors.white,), // Example: a search icon
                    hintText: "Nhập địa điểm",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color:Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

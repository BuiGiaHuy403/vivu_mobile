import 'package:flutter/material.dart';
import 'package:vivu_mobile/core/common/constants/app_color.dart';
import 'package:vivu_mobile/core/common/widget/nav_bar/tab_item.dart';

import '../../../routes/app_routes.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2), // đổ bóng lên trên
          ),
        ],
      ),
      child: BottomAppBar(
        elevation: 8.0,
        shadowColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.white,
        height: 100,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            )
          ),

          StadiumBorder(),
        ),
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _buildTabButton(TabItem.home)),
            Expanded(child: _buildTabButton(TabItem.explore)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 20,),
                  SafeArea(
                    child: Text(
                      "Lên Lịch Trình",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MAIN_BRIGHT_BLUE,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(child: _buildTabButton(TabItem.myTrip)),
            Expanded(child: _buildTabButton(TabItem.profile)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(TabItem tabItem) {
    final isSelected = currentTab == tabItem;

    final icon =
        isSelected
            ? ShaderMask(
              shaderCallback: (bounds) => MAIN_LINEAR_FULL.createShader(bounds),
              child: Icon(tabItem.tabData.icon, size: 40, color: Colors.white),
            )
            : Icon(tabItem.tabData.icon, size: 40, color: Colors.grey);

    final text = Text(
      tabItem.tabData.label,
      textAlign: TextAlign.center,
      maxLines: 2,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        color: isSelected ? MAIN_BRIGHT_BLUE : Colors.grey,
      ),
    );

    return TextButton(
      onPressed: () {
        onSelectTab(tabItem);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [icon, const SizedBox(height: 6.0), text],
      ),
    );
  }
}

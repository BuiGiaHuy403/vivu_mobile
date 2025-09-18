import 'package:flutter/material.dart';
import 'package:vivu_mobile/core/common/constants/app_color.dart';
import 'package:vivu_mobile/core/common/widget/nav_bar/bottom_navigation.dart';
import 'package:vivu_mobile/core/common/widget/nav_bar/tab_item.dart';
import 'package:vivu_mobile/core/routes/app_routes.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({
    super.key,
    this.initialTab = TabItem.home, // Allow setting initial tab
  });

  final TabItem initialTab;

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late TabItem _currentTab;

  final Map<TabItem, GlobalKey<NavigatorState>> _navigationKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.explore: GlobalKey<NavigatorState>(),
    TabItem.myTrip: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab; // Set initial tab from parameter
  }

  void _selectTab(TabItem tabItem) {
    // If the current tab is tapped again, pop to root of that tab

    if (tabItem == _currentTab) {
      _navigationKeys[tabItem]!.currentState?.popUntil(
        (route) => route.isFirst,
      );
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:
            TabItem.values
                .map((tabItem) => _buildOffstageNavigator(tabItem))
                .toList(),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: MAIN_LINEAR_FULL, // gradient bạn định nghĩa
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.planningScreen);
          },
          icon: Icon(Icons.add, color: Colors.white, size: 54),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: Navigator(
        key: _navigationKeys[tabItem],
        onGenerateRoute:
            (settings) => MaterialPageRoute(
              builder: (context) => tabItem.tabData.tabWidget,
              settings: settings,
            ),
      ),
    );
  }
}

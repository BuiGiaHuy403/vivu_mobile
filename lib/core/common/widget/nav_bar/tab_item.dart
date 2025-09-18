
import 'package:flutter/material.dart';
import 'package:vivu_mobile/feature/explore/presentation/explore.dart';
import 'package:vivu_mobile/feature/home/presentation/home_screen.dart';
import 'package:vivu_mobile/feature/my_trip/presentation/my_trip_main/my_trip_screen.dart';
import 'package:vivu_mobile/feature/profile/presentation/profile.dart';

import '../../../routes/app_routes.dart';

enum TabItem {
  home(
    TabData(icon: Icons.home_rounded, label: "Trang chủ", tabWidget: HomeScreen()),
  ),
  explore(
    TabData(icon: Icons.map_outlined, label: "Khám phá", tabWidget: ExploreScreen()),
  ),
  myTrip(
    TabData(icon: Icons.list_alt_rounded, label: "Chuyến đi của tôi", tabWidget: MyTripScreen()),
  ),
  profile(
    TabData(icon: Icons.person, label: "Tôi", tabWidget: ProfileScreen()),
  );

  const TabItem(this.tabData);
  final TabData tabData;
}



class TabData {
  final IconData icon;
  final String label;
  final Widget tabWidget;

  const TabData({
    required this.icon,
    required this.label,
    required this.tabWidget,
  });
}


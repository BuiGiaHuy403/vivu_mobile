import 'dart:ui';

import 'package:flutter/material.dart';

const MAIN_BRIGHT_BLUE = Color(0xFF7DDCFF);
const MAIN_BRIGHT_BLUE_2 = Color(0xFF89D9FF);

const MAIN_MEDIUM_BLUE = Color(0xFF40C4FF); // xanh trung
const MAIN_DARK_BLUE   = Color(0xFF00B0FF);
// xanh đậm

const MAIN_LINEAR_TOP = LinearGradient(
  colors: [MAIN_BRIGHT_BLUE, Colors.white],
  begin: Alignment.topCenter,
  stops: [0.2,0.4],
  end: Alignment.bottomCenter,
);


const MAIN_LINEAR = LinearGradient(
  colors: [MAIN_BRIGHT_BLUE, Colors.white],
  begin: Alignment.topCenter,
  stops: [0.5,1],
  end: Alignment.bottomCenter,
);

const MAIN_LINEAR_FULL = LinearGradient(
  colors: [
    MAIN_BRIGHT_BLUE,       // xanh đậm hơn
    MAIN_BRIGHT_BLUE_2,     // xanh trung gian
    Color(0xFFBCE8FD),      // xanh rất nhạt gần trắng
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.6, 1], // phân bố dần đều
);


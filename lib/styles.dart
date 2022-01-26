import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

const kPColor = Color(0xFF806EF8);
const kBColor = Colors.black54;

const kHintStyle = TextStyle(
  letterSpacing: 1.0,
  fontWeight: FontWeight.w400,
);

var kOutlineBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(30),
);

var kOutlineFocusedBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.blue, width: 2),
  borderRadius: BorderRadius.circular(15),
);

const kLoaderBtn = SizedBox(
  width: 20,
  height: 20,
  child: CircularProgressIndicator(
    strokeWidth: 1.5,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  ),
);

const kShimmerGradient = LinearGradient(
  colors: [
    Color(0xFFD8E3E7),
    Color(0xFFC8D5DA),
    Color(0xFFD8E3E7),
  ],
  stops: [
    0.1,
    0.5,
    0.9,
  ],
);

const kSkeletonAppbarStyle = SkeletonAvatarStyle(
  width: 45,
  height: 45,
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

const kDarkShimmerGradient = LinearGradient(
  colors: [
    Color(0xFF222222),
    Color(0xFF242424),
    Color(0xFF2B2B2B),
    Color(0xFF242424),
    Color(0xFF222222),
  ],
  stops: [
    0.0,
    0.2,
    0.5,
    0.8,
    1,
  ],
  begin: Alignment(-2.4, -0.2),
  end: Alignment(2.4, 0.2),
  tileMode: TileMode.clamp,
);

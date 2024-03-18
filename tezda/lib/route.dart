import 'package:flutter/material.dart';
import 'package:tezda/config/route.dart';
import 'package:tezda/screens/homescreen/screen/homescreen.dart';
import 'package:tezda/screens/login/screens/login.dart';
import 'package:tezda/screens/product/screen/product_detail.dart';
import 'package:tezda/screens/product/screen/products.dart';
import 'package:tezda/screens/profile/edit_profile.dart';

class PageRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.initial:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case AppRoute.homescreen:
        return MaterialPageRoute(
          builder: (context) => const Homescreen(),
        );
      case AppRoute.product:
        return MaterialPageRoute(
          builder: (context) => const Products(),
        );
      case AppRoute.productDetail:
        return MaterialPageRoute(
          builder: (context) => const ProductDetails(),
        );
      case AppRoute.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
        );

      default:
        return null;
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tezda/screens/homescreen/bloc/homescreen_bloc.dart';
import 'package:tezda/screens/login/bloc/login_bloc.dart';

import 'screens/product/bloc/product_detail_bloc.dart';
import 'screens/product/bloc/products_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<ProductsBloc>(create: (context) => ProductsBloc()),
        BlocProvider<ProductDetailBloc>(
            create: (context) => ProductDetailBloc()),
      ];
}

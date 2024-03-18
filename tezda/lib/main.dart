import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tezda/bloc_provider.dart';
import 'package:tezda/config/route.dart';
import 'package:tezda/firebase_options.dart';
import 'package:tezda/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'MakeFitSimple',
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      debugPrint("completedAppInitialize");
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final PageRouter pageRouter = PageRouter();
    return MultiBlocProvider(
        providers: AppBlocProviders.allBlocProviders,
        child: MaterialApp(
          title: 'Tezda',
          debugShowCheckedModeBanner: false,
          initialRoute: user != null ? AppRoute.homescreen : AppRoute.initial,
          onGenerateRoute: pageRouter.onGenerateRoute,
        ));
  }
}

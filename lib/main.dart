import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_market/ui/screens/home_screen.dart';

import 'cubit/cart_cubit.dart';
import 'cubit/products_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () =>  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CartCubit(),),
          BlocProvider(create: (context) => ProductsCubit(),),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home:  HomeScreen(),
        ),
      ),

    );
  }
}

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/cubits/counter_cubit.dart';
import '/presentation/screens/second_screen.dart';
import '/presentation/screens/third_screen.dart';

import '../screens/main_screen.dart';

class AppRouter {
  // final CounterCubit _counterCubit = CounterCubit();
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (context) => const ThirdScreen(
                  title: "Test 3",
                ));
        // builder: (_) => BlocProvider.value(
        //     value: _counterCubit,
        //     child: const MyHome(
        //       title: "Test 1",
        //     )));
        break;
      // case "/second":
      //   return MaterialPageRoute(
      //       builder: (context) => const secondScreen(
      //             title: "Test 2",
      //           ));
      //   // builder: (_) => BlocProvider.value(
      //   //     value: _counterCubit,
      //   //     child: const secondScreen(
      //   //       title: "Test 2",
      //   //     )));
      //   break;
      default:
        return null;
        break;
    }
  }

  // void dispose() {
  //   _counterCubit.close();
  // }
}

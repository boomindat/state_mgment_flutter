import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'business_logic/cubits/counter_cubit.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/second_screen.dart';
import 'presentation/screens/third_screen.dart';

import 'business_logic/cubits/internet_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
              internetCubit: BlocProvider.of<InternetCubit>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final AppRouter _appRouter = AppRouter();
//   // final CounterCubit _counterCubit = CounterCubit();
//   @override
//   void dispose() {
//     // _counterCubit.close();
//     _appRouter.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Counter Cubit",
//       theme: ThemeData.dark(),
//       onGenerateRoute: _appRouter.onGenerateRoute,
//       //named routing inside material app
//       // routes: {
//       //   '/': (context) => BlocProvider<CounterCubit>.value(
//       //       value: _counterCubit, child: MyHome(title: "Demo page")),
//       //   '/second': (context) => BlocProvider<CounterCubit>.value(
//       //       value: _counterCubit,
//       //       child: secondScreen(
//       //         title: "Demo Page 2",
//       //       ))
//       // });
//     );
//   }
// }

// class Increment extends CounterEvent {}

// class Decrement extends CounterEvent {}

// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<Increment>((event, emit) => emit(state + 1));
//     on<Decrement>((event, emit) => emit(state - 1));
//   }
// }

// Future<void> main(List<String> args) async {
//   final bloc = CounterBloc();

//   final streamSubscription = bloc.stream.listen(print);
//   bloc.add(Increment());
//   bloc.add(Increment());
//   bloc.add(Increment());
//   bloc.add(Increment());
//   bloc.add(Decrement());
//   bloc.add(Increment());
//   await Future.delayed(Duration(seconds: 2));
//   await streamSubscription.cancel();
//   await bloc.close();
// }
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
//   void increment() => emit(state + 1);
//   void decrement() => emit(state - 1);
// }

// void main(List<String> args) {
//   final cubit = CounterCubit();
//   print(cubit.state);
//   cubit.increment();
//   print(cubit.state);
//   cubit.increment();
//   print(cubit.state);
//   cubit.increment();
// }

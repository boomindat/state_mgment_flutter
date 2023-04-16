import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:statemanagement/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Counter Cubit",
            theme: ThemeData.dark(),
            home: MyHome(title: "flutter demo home page".toUpperCase())));
  }
}

class MyHome extends StatefulWidget {
  final String title;
  const MyHome({Key? key, required this.title}) : super(key: key);
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu_book_outlined),
        title: Text("Counter"),
      ),
      // body: BlocListener<CounterCubit, CounterState>(
      //   listener: (context, state) {
      //     if (state.wasIncremented) {
      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //         content: Text("Incremented"),
      //         duration: Duration(seconds: 2),
      //       ));
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //         content: Text("Decremented"),
      //         duration: Duration(seconds: 2),
      //       ));
      //     }
      //   },
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("You have pushed the button this many times"),
          BlocConsumer<CounterCubit, CounterState>(
            listener: (context, state) {
              if (state.wasIncremented) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Incremented"),
                  duration: Duration(milliseconds: 200),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Decremented"),
                  duration: Duration(milliseconds: 200),
                ));
              }
            },
            builder: (context, state) {
              return Text(state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                  // context.bloc<CounterCubit>().decrement();
                },
                tooltip: "Decrement",
                child: Icon(Icons.arrow_left),
              ),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                tooltip: "Increment",
                child: Icon(Icons.arrow_right),
              ),
            ],
          )
        ],
      )),
    );
    ;
  }
}

// abstract class CounterEvent {}

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

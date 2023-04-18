import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/cubits/counter_cubit.dart';
import '/presentation/screens/main_screen.dart';

class secondScreen extends StatefulWidget {
  final String title;
  const secondScreen({Key? key, required this.title}) : super(key: key);
  _secondScreenState createState() => _secondScreenState();
}

class _secondScreenState extends State<secondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
          ),
          SizedBox(height: 24),
          MaterialButton(
              child: Text("Go To first screen"),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      )),
    );
    ;
  }
}

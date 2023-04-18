import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagement/business_logic/cubits/counter_cubit.dart';
import 'package:statemanagement/business_logic/cubits/internet_cubit.dart';
import 'package:statemanagement/constant/enums.dart';
import 'package:statemanagement/presentation/screens/second_screen.dart';

class ThirdScreen extends StatefulWidget {
  final String title;
  const ThirdScreen({Key? key, required this.title}) : super(key: key);
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
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
          BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
            if (state is InternetConnected &&
                state.connectionType == ConnectionType.Wifi) {
              return Text("Wifi");
            } else if (state is InternetConnected &&
                state.connectionType == ConnectionType.Mobile) {
              return Text("Mobile");
            } else if (state is InternetDisconnected) {
              return Text('Disconnected');
            }
            return CircularProgressIndicator();
          }),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     FloatingActionButton(
          //       onPressed: () {
          //         BlocProvider.of<CounterCubit>(context).decrement();
          //         // context.bloc<CounterCubit>().decrement();
          //       },
          //       tooltip: "Decrement",
          //       child: Icon(Icons.arrow_left),
          //     ),
          //     FloatingActionButton(
          //       onPressed: () {
          //         BlocProvider.of<CounterCubit>(context).increment();
          //       },
          //       tooltip: "Increment",
          //       child: Icon(Icons.arrow_right),
          //     ),
          //   ],
          // ),
          SizedBox(height: 24),
          MaterialButton(
              child: Text("Go To second screen"),
              onPressed: () {
                Navigator.of(context).pushNamed("/second");
                //in the case of anonynomous routing
                // Navigator.of(context).push(MaterialPageRoute(
                //   //if the context used inside builder was named context
                //   //this would not work because it would not be the context
                //   //contains the counter cubit
                //   builder: (newContext) => BlocProvider.value(
                //       value: BlocProvider.of<CounterCubit>(context),
                //       child: secondScreen(title: "secondScreen")),
                // ));
              })
        ],
      )),
    );
    ;
  }
}

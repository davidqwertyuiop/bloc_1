import 'package:bloc_1/Business%20logic%20layer/cubit/internet_cubit.dart';
import 'package:bloc_1/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Business logic layer/cubit/counter_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children:<Widget> [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                	if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
                	  return Text('Wifi');
                	}else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile){
                    return Text('Mobile');
                  }else if (state is InternetDisconnected){
                    return Text('Disconnected');
                  }else if (state is InternetLoading){
                    return CircularProgressIndicator();
                  }
                return BlocListener<CounterCubit, CounterState>(
                  listener: (context, state) {
                    if (state.wasIncremented == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Incremented!'),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    } else if (state.wasIncremented == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Decremented!'),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        BlocBuilder<CounterCubit, CounterState>(
                          builder: (context, state) {
                            return Text(
                              state.counter.toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                                onPressed: () {
                                  BlocProvider.of<CounterCubit>(context)
                                      .decrement();
                                  //context.read<CounterCubit>().decrement();
                                },
                                child: const Icon(Icons.remove)),
                            FloatingActionButton(
                                onPressed: () {
                                  context.read<CounterCubit>().increment();
                                },
                                child: const Icon(Icons.add)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/second');
                          },
                          child: Text('Go to Second Page'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/third');
                          },
                          child: Text('Go to third Page'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

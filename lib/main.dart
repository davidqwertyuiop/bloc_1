import 'package:bloc_1/Business%20logic%20layer/cubit/counter_cubit.dart';
import 'package:bloc_1/Business%20logic%20layer/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Presentation_layer/router/app_router.dart';

void main() {
  runApp(MyApp(connectivity: Connectivity(), appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.connectivity, required this.appRouter});

  final AppRouter appRouter;
  final Connectivity connectivity;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (_) => CounterCubit(internetCubit:context.read<Connectivity>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Tutorial',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

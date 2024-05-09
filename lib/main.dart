import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesping_experience/blocs/gps/gps_bloc.dart';

import 'screens/screens.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
    ],
    child: const VespingApp(),
  ));
}

class VespingApp extends StatelessWidget {
  const VespingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingScreen());
  }
}

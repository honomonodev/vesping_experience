import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() => runApp(const VespingApp());

class VespingApp extends StatelessWidget {
  const VespingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: GpsAccessScreen());
  }
}

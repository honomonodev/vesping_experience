import 'package:flutter/material.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Es necesario el acceso al GPS',
        ),
        MaterialButton(
          color: Colors.black,
          shape: const StadiumBorder(),
          onPressed: () {
            //TODO: Solicitar acceso al GPS
          },
          elevation: 0,
          splashColor: Colors.transparent,
          child: const Text(
            'Soliciter acceso al GPS',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Text('Debe de habilitar el GPS',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300));
  }
}

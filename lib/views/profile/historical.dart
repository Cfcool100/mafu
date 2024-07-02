import 'package:flutter/material.dart';
import 'package:mafuriko/utils/themes.dart';

class Historical extends StatelessWidget {
  const Historical({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Historiques'),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Aucune historique de\n contributions disponible',
            textAlign: TextAlign.center,
            style: AppTheme.textSemiBoldH5,
          ),
        ));
  }
}

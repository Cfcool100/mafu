import 'package:flutter/material.dart';
import 'package:mafuriko/utils/themes.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prédiction'),
      ),
      body: Center(
        child: Text('En cours de developpement...', style: AppTheme.textSemiBoldH5,),
      ),
    );
  }
}

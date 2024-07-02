import 'package:equatable/equatable.dart';

class FloodAlert extends Equatable {
  final Map<String, String>? floodLocation;
  final String? floodScene;
  final String floodDate;
  final String? floodDescription;
  final String floodIntensity;
  final String? floodImages;

  const FloodAlert({
    required this.floodLocation,
    this.floodScene,
    required this.floodDate,
    required this.floodDescription,
    required this.floodIntensity,
    this.floodImages,
  });

  factory FloodAlert.fromJson(Map<String, dynamic> json) {
    return FloodAlert(
      floodLocation:
          json['floodLocation'] ?? {"latitude": "0.0", "longitude": "0.0"},
      floodScene: json['floodScene'] as String?,
      floodDate: json['floodDate'],
      floodDescription: json['floodDescription'] ?? 'NaN',
      floodIntensity: json['floodIntensity'],
      floodImages: json['floodImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'floodLocation': floodLocation,
      'floodScene': floodScene,
      'floodDate': floodDate,
      'floodDescription': floodDescription,
      'floodIntensity': floodIntensity,
      'floodImages': floodImages,
    };
  }

  // String toJson() => json.encode(
  //       <String, dynamic>{
  //         'floodLocation': floodLocation,
  //         'floodDate': floodDate.toUtc().toIso8601String(),
  //         'floodDescription': floodDescription,
  //         'floodIntensity': floodIntensity,
  //         // 'floodImages': floodImages,
  //       },
  //     );

  @override
  List<Object?> get props => [
        floodLocation,
        floodScene,
        floodDate,
        floodDescription,
        floodIntensity,
      ];
}


// {"_id":"667f0d77cc2c5726a65e4041","floodScene":"Cocody, Abidjan","floodDescription":"Une forte tempête tropicale approche de Cocody avec des vents violents atteignant des vitesses dangereuses et des précipitations intenses. Il est conseillé de sécuriser les objets à l'extérieur et de se préparer à des coupures de courant potentielles.","floodIntensity":"Élevé","floodImage":"https://propay-storage.ams3.digitaloceanspaces.com/alerts/1719602545887","floodDate":"2024-06-28T19:22:31.968Z","__v":0}

// {"_id":"667f0d7954ff1d82024541b9","floodScene":"Cocody, Abidjan","floodDescription":"Une forte tempête tropicale approche de Cocody avec des vents violents atteignant des vitesses dangereuses et des précipitations intenses. Il est conseillé de sécuriser les objets à l'extérieur et de se préparer à des coupures de courant potentielles.","floodIntensity":"Élevé","floodImage":"https://propay-storage.ams3.digitaloceanspaces.com/alerts/1719602546505","floodDate":"2024-06-28T19:22:33.638Z","__v":0}
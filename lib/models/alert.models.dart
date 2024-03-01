import 'package:equatable/equatable.dart';


class FloodAlert extends Equatable{
  final Map<String, String> floodLocation;
  final String floodDate;
  final String floodDescription;
  final String floodIntensity;
  // final List<String> floodImages;

  const FloodAlert({
    required this.floodLocation,
    required this.floodDate,
    required this.floodDescription,
    required this.floodIntensity,
    // required this.floodImages,
  });

  factory FloodAlert.fromJson(Map<String, dynamic> json) {
    return FloodAlert(
      floodLocation: Map<String, String>.from(json['floodLocation']),
      floodDate: json['floodDate'],
      floodDescription: json['floodDescription'],
      floodIntensity: json['floodIntensity'],
      // floodImages: json['floodImages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'floodLocation': floodLocation,
      'floodDate': floodDate,
      'floodDescription': floodDescription,
      'floodIntensity': floodIntensity,
      // 'floodImages': floodImages,
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
  List<Object?> get props => [floodLocation, floodDate, floodDescription, floodIntensity, ];
}

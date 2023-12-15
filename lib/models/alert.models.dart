class FloodAlert {
  Map<String, String> floodLocation;
  DateTime floodDate;
  String floodDescription;
  String floodIntensity;
  List<String> floodImages;

  FloodAlert({
    required this.floodLocation,
    required this.floodDate,
    required this.floodDescription,
    required this.floodIntensity,
    required this.floodImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'floodLocation': floodLocation,
      'floodDate': floodDate.toUtc().toIso8601String(),
      'floodDescription': floodDescription,
      'floodIntensity': floodIntensity,
      'floodImages': floodImages,
    };
  }
}

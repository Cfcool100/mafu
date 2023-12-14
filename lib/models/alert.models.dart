class Alert {
  final String location;
  final String description;
  final DateTime hours;
  final DateTime date;
  final String intensity;
  final String? image;

  Alert({
    required this.location,
    required this.date,
    required this.hours,
    required this.description,
    required this.intensity,
    this.image,
  });
}

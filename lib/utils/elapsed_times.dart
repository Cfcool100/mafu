import 'package:intl/intl.dart';

String formatElapsedTime(String dateStr) {
  DateTime givenDate = DateTime.parse(dateStr);
  DateTime now = DateTime.now();
  Duration difference = now.difference(givenDate);

  if (difference.inMinutes < 1) {
    // Moins d'une minute passée
    return 'à l\'instant';
  } else if (difference.inMinutes < 60) {
    // Plus d'une minute mais moins d'une heure passée
    return 'il y a ${difference.inMinutes} min';
  } else if (difference.inHours < 24) {
    // Plus d'une heure mais moins d'un jour passée
    return 'il y a ${difference.inHours} H';
  } else if (difference.inDays == 1) {
    // Entre 24 et 48 heures passées, retournez "hier"
    return 'Hier';
  } else if (difference.inDays > 1 && givenDate.year == now.year) {
    // Plus d'un jour passée mais dans la même année
    return DateFormat('dd MMMM', 'fr').format(givenDate);
  } else {
    // Plus d'un an passé ou plus d'un jour dans une année différente
    return DateFormat('dd MMMM yyyy', 'fr').format(givenDate);
  }
}

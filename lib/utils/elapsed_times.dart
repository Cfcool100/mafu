import 'package:intl/intl.dart';

String formatElapsedTime(String dateStr) {
  DateTime givenDate = DateTime.parse(dateStr);
  DateTime now = DateTime.now();
  Duration difference = now.difference(givenDate);

  if (givenDate.year == now.year) {
    // Si l'année est inférieure à l'année actuelle, afficher le jour et le mois
    return DateFormat('dd MMMM', 'fr').format(givenDate);
  } else if (difference.inDays > 1) {
    // Plus de 24 heures passées, donc retournez la date formatée
    return DateFormat('dd MMMM yyyy', 'fr').format(givenDate);
  } else if (difference.inDays == 1) {
    // Entre 24 et 48 heures passées, retournez "hier"
    return 'Hier';
  } else if (difference.inHours >= 1) {
    // Plus d'une heure passée aujourd'hui
    return '${difference.inHours} heures';
  } else if (difference.inMinutes >= 1) {
    // Plus d'une minute passée aujourd'hui
    return '${difference.inMinutes} minutes';
  } else {
    // Moins d'une minute passée
    return 'à l\'instant';
  }
}

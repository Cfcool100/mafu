// place_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaceService {
  final String apiKey;

  PlaceService(this.apiKey);

  Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return List<Map<String, dynamic>>.from(data['predictions']);
      } else {
        throw Exception('Failed to load suggestions');
      }
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return data['result']['geometry']['location'];
      } else {
        throw Exception('Failed to load place details');
      }
    } else {
      throw Exception('Failed to load place details');
    }
  }
}









// AIzaSyAxtdCodXhHS0rd8MbX61O28jKuDlLRFUY
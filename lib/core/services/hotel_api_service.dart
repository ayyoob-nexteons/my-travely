import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hotel.dart';

class HotelApiService {
  static const String baseUrl = 'https://api.mytravaly.com/public/v1';
  static const String authToken = '71523fdd8d26f585315b4233e39d9263';
  
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authtoken': authToken,
    'visitortoken': '',
  };

  /// Get popular hotels (for home page)
  static Future<List<Hotel>> getPopularHotels({int limit = 10}) async {
    try {
      final request = PopularStayRequest(limit: limit);
      final requestBody = jsonEncode(request.toJson());

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == true && jsonData['data'] != null) {
          return (jsonData['data'] as List<dynamic>)
              .map((hotel) => Hotel.fromPopularStayJson(hotel))
              .toList();
        } else {
          throw Exception('Failed to get popular hotels: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to get popular hotels: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting popular hotels: $e');
    }
  }

  /// Search hotels with detailed criteria
  static Future<HotelSearchResponse> searchHotels(HotelSearchRequest request) async {
    try {
      final requestBody = jsonEncode(request.toJson());

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == true) {
          return HotelSearchResponse.fromJson(jsonData);
        } else {
          throw Exception('Search failed: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to search hotels: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching hotels: $e');
    }
  }

  /// Search hotels by name, city, state, or country
  static Future<HotelSearchResponse> searchHotelsByQuery(String query) async {
    try {
      // Create a simple search request
      final request = HotelSearchRequest(
        checkIn: _getTomorrowDate(),
        checkOut: _getDayAfterTomorrowDate(),
        rooms: 1,
        adults: 2,
        children: 0,
        searchType: 'textSearch',
        searchQuery: [query],
        limit: 20,
      );

      return await searchHotels(request);
    } catch (e) {
      throw Exception('Error searching hotels by query: $e');
    }
  }

  /// Get hotels by city
  static Future<List<Hotel>> getHotelsByCity(String city, {int limit = 10}) async {
    try {
      final request = PopularStayRequest(
        limit: limit,
        city: city,
        searchType: 'byCity',
      );
      final requestBody = jsonEncode(request.toJson());

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == true && jsonData['data'] != null) {
          return (jsonData['data'] as List<dynamic>)
              .map((hotel) => Hotel.fromPopularStayJson(hotel))
              .toList();
        } else {
          throw Exception('Failed to get hotels by city: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to get hotels by city: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting hotels by city: $e');
    }
  }

  /// Helper method to get tomorrow's date
  static String _getTomorrowDate() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
  }

  /// Helper method to get day after tomorrow's date
  static String _getDayAfterTomorrowDate() {
    final dayAfterTomorrow = DateTime.now().add(const Duration(days: 2));
    return '${dayAfterTomorrow.year}-${dayAfterTomorrow.month.toString().padLeft(2, '0')}-${dayAfterTomorrow.day.toString().padLeft(2, '0')}';
  }
}

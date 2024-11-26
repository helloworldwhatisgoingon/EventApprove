import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hod_app/config.dart';

class Repository {
  Config config = Config();
  Dio dio = Dio();

  // Constructor to initialize Dio instance

  Future<List<Map<String, dynamic>>> fetchProposals() async {
    try {
      final String endpoint = "${config.baseURL}/event";
      final response = await Dio().get(endpoint);
      final List eventsJson = response.data['events'];

      return eventsJson.map((json) => json as Map<String, dynamic>).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching events: $e");
      }
      rethrow;
    }
  }

  // PUT request to update the request status (Accept/Reject)
  Future<Map<String, dynamic>> updateRequestStatus(
      int eventID, bool status) async {
    final url =
        '${config.baseURL}/event/approval/$eventID'; // Endpoint for updating a specific request

    // Data to send with PUT request
    Map<String, dynamic> data = {
      'approval': status,
    };

    try {
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response.
        return response.data;
      } else {
        // If the server returns a non-200 response, throw an error
        throw Exception('Failed to update request status');
      }
    } catch (e) {
      throw Exception('Error during PUT request: $e');
    }
  }
}

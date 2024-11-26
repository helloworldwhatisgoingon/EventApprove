import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:faculty_app/config.dart';
import 'package:flutter/foundation.dart';

class Repository {
  Config config = Config();

  Future<void> submitProposal({
    required String eventName,
    required String eventType,
    required String startDate,
    required String endDate,
    required String location,
    required String faculty,
    required String timings,
    required bool approval,
    String? documentPath,
  }) async {
    final String endpoint = "${config.baseURL}/event";
    final Dio dio = Dio();

    try {
      final formData = FormData.fromMap({
        "eventTitle": eventName,
        "eventType": eventType,
        "startDate": startDate,
        "endDate": endDate,
        "timings": timings,
        "faculty": faculty,
        "location": location,
        "approval": approval,
        if (documentPath != null)
          "eventPDF": await MultipartFile.fromFile(
            documentPath,
            filename: documentPath.split('/').last,
          ),
      });
      log('$documentPath $eventName $startDate');
      log(endpoint);
      final response = await dio.post(endpoint, data: formData);

      if (response.statusCode == 201) {
        log('success');
        log('$response');
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to submit proposal: ${response.statusMessage}");
      }
    } catch (e) {
      rethrow; // Pass the exception back to the caller for handling
    }
  }

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
}

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

  Future<void> submitConference({
    required String paperTitle,
    required String abstract,
    required String conferenceName,
    required String publicationLevel,
    required String publicationDate,
    required String publisher,
    required String doiIsbn,
    String? documentPath,
    required String proofLink,
    required String identifier,
  }) async {
    final String endpoint = "${config.baseURL}/conference";
    final Dio dio = Dio();

    try {
      final formData = FormData.fromMap({
        "papertitle": paperTitle,
        "abstract": abstract,
        "conferencename": conferenceName,
        "publicationlevel": publicationLevel,
        "publicationdate": publicationDate,
        "publisher": publisher,
        "doiisbn": doiIsbn,
        "prooflink": proofLink,
        "identifier": identifier,
        if (documentPath != null)
          "document": await MultipartFile.fromFile(
            documentPath,
            filename: documentPath.split('/').last,
          ),
      });

      log('$documentPath $paperTitle $publicationDate');
      log(endpoint);

      final response = await dio.post(endpoint, data: formData);

      if (response.statusCode == 201) {
        log('success');
        log('$response');
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            "Failed to submit proposal: \${response.statusMessage}");
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

  Future<List<Map<String, dynamic>>> fetchConference() async {
    try {
      final String endpoint = "${config.baseURL}/conference";
      final response = await Dio().get(endpoint);
      print('$response');
      final List conferenceJson = response.data['conferences'];

      return conferenceJson
          .map((json) => json as Map<String, dynamic>)
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching conferences: $e");
      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      // Fetch proposals and conferences concurrently
      final proposals = await fetchProposals();
      final conferences = await fetchConference();

      // Merge both lists of maps into a single list
      List<Map<String, dynamic>> mergedData = [];
      mergedData.addAll(proposals);
      mergedData.addAll(conferences);

      return mergedData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
      rethrow;
    }
  }
}

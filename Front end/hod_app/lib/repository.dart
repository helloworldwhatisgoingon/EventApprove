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

  Future<Map<String, dynamic>> updateConferenceStatus(
      int conferenceId, bool status) async {
    final url =
        '${config.baseURL}/conference/approval/$conferenceId'; // Endpoint for updating a specific request

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

  Future<Map<String, dynamic>> deleteRequest(int eventID) async {
    final url = '${config.baseURL}/event/$eventID';

    try {
      final response = await dio.delete(url);

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

  Future<Map<String, dynamic>> deleteConference(int conferenceId) async {
    final url = '${config.baseURL}/conference/$conferenceId';

    try {
      final response = await dio.delete(url);

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

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      // Fetch proposals and conferences concurrently
      // final proposals = await fetchProposals();
      final conferences = await fetchConference();

      // Merge both lists of maps into a single list
      List<Map<String, dynamic>> mergedData = [];

      // Add 'submissionType' to each proposal
      // for (var proposal in proposals) {
      //   proposal['submissionType'] = 'proposal';  // Add 'submissionType' field
      //   mergedData.add(proposal);
      // }

      // Add 'submissionType' to each conference
      for (var conference in conferences) {
        conference['submissionType'] =
            'conference'; // Add 'submissionType' field
        mergedData.add(conference);
      }

      return mergedData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
      rethrow;
    }
  }
}

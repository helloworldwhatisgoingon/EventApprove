import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:faculty_app/config.dart';
import 'package:flutter/foundation.dart';

class Repository {
  Config config = Config();

  Future<void> sendEvent({
    required String eventType,
    required String eventName,
    required Map<String, dynamic> additionalData,
  }) async {
    final dio = Dio();
    final url = '${config.baseURL}/centralized';

    // Check if there's a MultipartFile in the additionalData
    bool hasFile = additionalData.values.any((value) => value is MultipartFile);

    try {
      if (hasFile) {
        // If there's a file, use FormData
        final formData = FormData.fromMap({
          "event_type": eventType,
          "event_name": eventName,
          ...additionalData,
        });

        final response = await dio.post(
          url,
          data: formData,
        );
        print('Response: ${response.data}');
      } else {
        // If no file, use regular JSON
        final data = {
          "event_type": eventType,
          "event_name": eventName,
          ...additionalData,
        };

        final response = await dio.post(
          url,
          data: data,
          options: Options(headers: {'Content-Type': 'application/json'}),
        );
        print('Response: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow to allow handling in the calling function
    }
  }

  Future<Map<String, dynamic>> createConferenceData({
    required String paperTitle,
    required String abstract,
    required String conferenceName,
    required String publicationLevel,
    required String publicationDate,
    required String publisher,
    required String doiIsbn,
    required String identifier,
    String? documentPath,
    required String proofLink,
  }) async {
    final Map<String, dynamic> data = {
      "papertitle": paperTitle,
      "abstract": abstract,
      "conferencename": conferenceName,
      "publicationlevel": publicationLevel,
      "publicationdate": publicationDate,
      "publisher": publisher,
      "doiisbn": doiIsbn,
      "prooflink": proofLink,
      "identifier": identifier,
    };

    if (documentPath != null) {
      // Read the file as bytes
      final file = File(documentPath);
      final bytes = await file.readAsBytes();

      // Create MultipartFile from bytes
      data["document"] = MultipartFile.fromBytes(
        bytes,
        filename: documentPath.split('/').last,
      );
    }

    return data;
  }

  Future<Map<String, dynamic>> createJournalData({
    required String authors,
    required String paperTitle,
    String? abstract,
    String? journalName,
    String? publicationLevel,
    DateTime? publicationDate,
    String? publisher,
    String? doiIsbn,
    String? documentPath,
    String? proofLink,
    double? impactFactor,
    String? quartile,
    required String identifier,
  }) async {
    final Map<String, dynamic> data = {
      "authors": authors,
      "papertitle": paperTitle,
      "abstract": abstract,
      "journalname": journalName,
      "publicationlevel": publicationLevel,
      "publicationdate": publicationDate,
      "publisher": publisher,
      "doiisbn": doiIsbn,
      "prooflink": proofLink,
      "impactfactor": impactFactor,
      "quartile": quartile,
      "identifier": identifier,
    };

    if (documentPath != null) {
      // Read the file as bytes
      final file = File(documentPath);
      final bytes = await file.readAsBytes();

      // Create MultipartFile from bytes
      data["document"] = MultipartFile.fromBytes(
        bytes,
        filename: documentPath.split('/').last,
      );
    }

    return data;
  }

  Future<Map<String, dynamic>> createBookChapterData({
    required String authors,
    required String paperTitle,
    String? abstract,
    String? journalName,
    String? publicationLevel,
    DateTime? publicationDate,
    String? publisher,
    String? doi,
    String? documentPath,
    String? proofLink,
    required String identifier,
  }) async {
    final Map<String, dynamic> data = {
      "authors": authors,
      "papertitle": paperTitle,
      "abstract": abstract,
      "journalname": journalName,
      "publicationlevel": publicationLevel,
      "publicationdate": publicationDate,
      "publisher": publisher,
      "doi": doi,
      "prooflink": proofLink,
      "identifier": identifier,
    };

    if (documentPath != null) {
      // Read the file as bytes
      final file = File(documentPath);
      final bytes = await file.readAsBytes();

      // Create MultipartFile from bytes
      data["document"] = MultipartFile.fromBytes(
        bytes,
        filename: documentPath.split('/').last,
      );
    }

    return data;
  }

  Future<Map<String, dynamic>> createWorkshopData({
    required String workshopTitle,
    String? mode,
    String? dates,
    String? days,
    String? organizers,
    String? conveners,
    String? speakersDetails,
    String? sanctionedAmount,
    String? facultyReceivingAmount,
    int? identifier,
    String? reportPath,
    String? feedbackPath,
    String? participantsListPath,
    String? certificatesPath,
    String? expenditureReportPath,
    String? gpsMediaPath,
    String? brochurePath,
  }) async {
    final Map<String, dynamic> data = {
      "workshoptitle": workshopTitle,
      "mode": mode,
      "dates": dates,
      "days": days,
      "organizers": organizers,
      "conveners": conveners,
      "speakersdetails": speakersDetails,
      "sanctionedamount": sanctionedAmount,
      "facultyreceivingamount": facultyReceivingAmount,
      "identifier": identifier,
    };

    if (brochurePath != null) {
      final file = File(brochurePath);
      final bytes = await file.readAsBytes();
      data["brochure"] = MultipartFile.fromBytes(bytes,
          filename: brochurePath.split('/').last);
    }

    if (gpsMediaPath != null) {
      final file = File(gpsMediaPath);
      final bytes = await file.readAsBytes();
      data["gpsmedia"] = MultipartFile.fromBytes(bytes,
          filename: gpsMediaPath.split('/').last);
    }

    if (reportPath != null) {
      final file = File(reportPath);
      final bytes = await file.readAsBytes();
      data["report"] =
          MultipartFile.fromBytes(bytes, filename: reportPath.split('/').last);
    }

    if (feedbackPath != null) {
      final file = File(feedbackPath);
      final bytes = await file.readAsBytes();
      data["feedback"] = MultipartFile.fromBytes(bytes,
          filename: feedbackPath.split('/').last);
    }

    if (participantsListPath != null) {
      final file = File(participantsListPath);
      final bytes = await file.readAsBytes();
      data["participantslist"] = MultipartFile.fromBytes(bytes,
          filename: participantsListPath.split('/').last);
    }

    if (certificatesPath != null) {
      final file = File(certificatesPath);
      final bytes = await file.readAsBytes();
      data["certificates"] = MultipartFile.fromBytes(bytes,
          filename: certificatesPath.split('/').last);
    }

    if (expenditureReportPath != null) {
      final file = File(expenditureReportPath);
      final bytes = await file.readAsBytes();
      data["expenditurereport"] = MultipartFile.fromBytes(bytes,
          filename: expenditureReportPath.split('/').last);
    }

    return data;
  }

 Future<Map<String, dynamic>> getEventByMasterId(int masterId) async {
    try {
      final dio = Dio();
      // Replace with your base URL
      dio.options.baseUrl = '${config.baseURL}/centralized';

      final response = await dio.get('/$masterId');

      if (response.statusCode == 200) {
        // The API returns a JSON object, so we'll return it as Map<String, dynamic>
        return response.data as Map<String, dynamic>;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: 'Failed to fetch event data',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw 'Event not found';
      }
      throw 'Error fetching event: ${e.message}';
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  Future<List<dynamic>> getAllMasterEvents() async {
    final Dio dio = Dio();

    try {
      // Configure Dio (e.g., base URL, headers)
      dio.options.baseUrl =
          '${config.baseURL}/centralized'; // Replace with your API base URL
      dio.options.headers = {
        'Content-Type': 'application/json',
      };

      // Make the GET request
      final response = await dio.get('/all');

      // Handle response
      if (response.statusCode == 200) {
        List<dynamic> masterEvents = response.data;
        print('Master Events fetched successfully: $masterEvents');
        return masterEvents;
      } else {
        print('Failed to fetch events: ${response.statusMessage}');
      }
      return [];
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }
  
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

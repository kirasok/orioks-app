import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../repository/token_repository.dart';
import 'api_constants.dart';
import 'user_agent_client.dart';

class ApiService {
  final UserAgentClient _client = UserAgentClient(http.Client());

  final Logger _logger = Logger();

  static final ApiService _instance = ApiService._();

  ApiService._();

  factory ApiService() => _instance;

  Future<String> fetchToken(String encodedCredentials) async {
    _logger.d("Trying to get token");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.authEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
        HttpHeaders.acceptHeader: "application/json",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch token, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchSchedule() async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get schedule");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.scheduleEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch schedule, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchGroups() async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get group list");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.groupListEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch group list, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchTimetable() async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get group list");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.timetableEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch timetable, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchScheduleOfGroup(int groupId) async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get schedule of group");
    var url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.groupListEndpoint}/$groupId");
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch schedule of group, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchStudent() async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get student");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.studentEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch student, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchDisciplines() async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get disciplines");
    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.disciplinesEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch disciplines, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  Future<String> fetchEvents(int disciplineId) async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get events of $disciplineId");
    var url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.disciplinesEndpoint}/$disciplineId${ApiConstants.eventsEndpoint}");
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to fetch events of $disciplineId, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

// TODO: ask someone who has academic debts to test
  Future<void> fetchAcademicDepts() async {
    final token = await TokenRepository().get();
    _logger.d("Trying to get academic debts");
    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.academicDebtsEndpoint);
    final response = await _client.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${token.token}",
      },
    );
    _logger.d(response.body);
    if (response.statusCode == 200) {
    } else {
      throw Exception(
          "Failed to fetch academic depts, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }
}

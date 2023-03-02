import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:orioks/api/api_constants.dart';
import 'package:orioks/api/user_agent_client.dart';
import 'package:orioks/datamodel/token.dart';

class ApiService {
  static UserAgentClient client = UserAgentClient(http.Client());

  static Future<Token> fetchToken(String login, String password) async {
    final String credentials = '$login:$password';
    var stringToBase64 = utf8.fuse(base64);
    var encodedCredentials = stringToBase64.encode(credentials);

    var logger = Logger();
    logger.d("Trying to get token");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.authEndpoint);
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
        HttpHeaders.acceptHeader: "application/json",
      },
    );
    logger.d(response.body);
    logger.close();
    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Failed to fetch token, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }

  static Future<void> fetchSchedule() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get schedule");
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.scheduleEndpoint);
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      logger.close();
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch schedule, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }

  static Future<void> fetchGroupList() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get group list");
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.groupListEndpoint);
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch group list, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }

  static Future<void> fetchTimetable() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get group list");
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.timetableEndpoint);
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch timetable, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }

  static Future<void> fetchScheduleOfGroup() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get group list");
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.groupListEndpoint + "/1620");
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch schedule of group, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }

  static Future<void> fetchStudent() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get group list");
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.studentEndpoint);
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch schedule of group, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }

  static Future<void> fetchDisciplines() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get group list");
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.disciplinesEndpoint);
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch schedule of group, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }

  static Future<void> fetchAcademicDepts() async {
    final token = await TokenRepository.read();
    if (token != null) {
      var logger = Logger();
      logger.d("Trying to get group list");
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.academicDebtsEndpoint);
      final response = await client.get(
        url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.token}",
        },
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            "Failed to fetch schedule of group, status code: ${response.statusCode}, response body: ${response.body}");
      }
    } else {
      throw Exception("Token is null");
    }
  }
}

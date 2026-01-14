import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/log.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient(this.baseUrl, {http.Client? client}) : _client = client ?? http.Client();

  Uri _u(String path) => Uri.parse('$baseUrl$path');

  // ---------- TRIPS ----------

  Future<List<dynamic>> getTrips() async {
    final url = _u('/trips');
    try {
      log.d("HTTP GET $url");
      final res = await _client.get(url).timeout(const Duration(seconds: 5));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final decoded = jsonDecode(res.body);
        if (decoded is List) return decoded;
        throw ApiException("Server returned invalid trips list.");
      }

      throw _errFromResponse(res);
    } catch (e) {
      log.e("getTrips failed", error: e);
      rethrow;
    }
  }

  /// Send ONLY created fields (no id). Server returns created trip with id.
  Future<Map<String, dynamic>> createTrip(Map<String, dynamic> body) async {
    final url = _u('/trips');
    try {
      log.d("HTTP POST $url body=${body.keys.toList()}");
      final res = await _client
          .post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 5));

      if (res.statusCode == 201 || (res.statusCode >= 200 && res.statusCode < 300)) {
        final decoded = jsonDecode(res.body);
        if (decoded is Map<String, dynamic>) return decoded;
        throw ApiException("Server returned invalid created trip.");
      }

      throw _errFromResponse(res);
    } catch (e) {
      log.e("createTrip failed", error: e);
      rethrow;
    }
  }

  /// PUT keeps id in URL. Server returns updated trip.
  Future<Map<String, dynamic>> updateTrip(String id, Map<String, dynamic> body) async {
    final url = _u('/trips/$id');
    try {
      log.d("HTTP PUT $url body=${body.keys.toList()}");
      final res = await _client
          .put(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 5));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final decoded = jsonDecode(res.body);
        if (decoded is Map<String, dynamic>) return decoded;
        throw ApiException("Server returned invalid updated trip.");
      }

      throw _errFromResponse(res);
    } catch (e) {
      log.e("updateTrip failed", error: e);
      rethrow;
    }
  }

  /// Only id is sent (in URL). Server returns 204.
  Future<void> deleteTrip(String id) async {
    final url = _u('/trips/$id');
    try {
      log.d("HTTP DELETE $url");
      final res = await _client.delete(url).timeout(const Duration(seconds: 5));

      if (res.statusCode == 204 || (res.statusCode >= 200 && res.statusCode < 300)) {
        return;
      }

      throw _errFromResponse(res);
    } catch (e) {
      log.e("deleteTrip failed", error: e);
      rethrow;
    }
  }

  // ---------- helpers ----------

  ApiException _errFromResponse(http.Response res) {
    // NU arăta raw error în UI -> facem mesaj prietenos
    try {
      final decoded = jsonDecode(res.body);
      if (decoded is Map && decoded['error'] != null) {
        return ApiException(decoded['error'].toString(), statusCode: res.statusCode);
      }
    } catch (_) {}

    return ApiException(
      "Server error. Please try again.",
      statusCode: res.statusCode,
    );
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  @override
  String toString() => "ApiException(status=$statusCode, message=$message)";
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/model/community.dart';

Future<List<Community>> fetchLink(http.Client client) async {
  final response = await client
      .get('https://yusufcakmak.github.io/topluluk-rehberi/data.json');

  var responseJson = json.decode(response.body);
  return (responseJson['communities'] as List)
      .map((p) => Community.fromJson(p))
      .toList();
}

List<Community> parseCommunities(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Community>((json) => Community.fromJson(json)).toList();
}
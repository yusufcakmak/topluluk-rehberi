import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/community.dart';

Future<List<Community>> fetchLink(http.Client client) async {
  final response =
  await client.get('https://yusufcakmak.github.io/topluluk-rehberi/data.json');

  var responseJson = json.decode(response.body);
  return (responseJson['communities'] as List)
      .map((p) => Community.fromJson(p))
      .toList();
}

List<Community> parseCommunities(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Community>((json) => Community.fromJson(json)).toList();
}


class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Community>>(
        future: fetchLink(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CommunityList(communities: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


class CommunityList extends StatelessWidget {
  final List<Community> communities;

  CommunityList({Key key, this.communities}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: communities.length,
      itemBuilder: (BuildContext context, int index) {
        return new Text(communities[index].links.twitter??'default value');
      },
    );
  }
}

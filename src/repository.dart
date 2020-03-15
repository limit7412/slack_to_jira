import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import './models.dart';

class SlackRepository {
  final String url;
  SlackRepository(this.url);

  Future<String> sendPost(List<SlackPost> posts) async {
    final res = await http.post(url, body: json.encode({'attachments': posts}));
    return res.body;
  }
}

class JiraRepository {
  JiraRepository();

  Future<bool> createTask(JiraTask task) async {
    final url =
        'https://' + Platform.environment['JIRA_WORKSPACE'] + '.atlassian.net';
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' +
          base64.encode(utf8.encode(Platform.environment['JIRA_USERNAME'] +
              ":" +
              Platform.environment['JIRA_TOKEN'])),
    };
    final res = await http.post(url + '/rest/api/3/issue',
        body: json.encode({'fields': task}), headers: headers);
    return res.statusCode == 201;
  }
}

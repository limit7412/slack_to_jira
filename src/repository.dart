import 'package:http/http.dart' as http;
import 'dart:convert';
import './models.dart';

class SlackRepository {
  final String url;
  SlackRepository(this.url);

  Future<String> sendPost(List<SlackPost> posts) async {
    final res = await http.post(url, body: json.encode({'attachments': posts}));
    return res.body;
  }
}

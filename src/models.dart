import 'dart:convert';

class SlackPost {
  final String fallback;
  final String pretext;
  final String title;
  final String text;
  final String color;
  final String footer;

  SlackPost(
    this.fallback,
    this.pretext,
    this.title,
    this.text,
    this.color,
    this.footer,
  );

  Map<String, String> toJson() => {
        'fallback': fallback,
        'pretext': pretext,
        'title': title,
        'text': text,
        'color': color,
        'footer': footer,
      };
}

class JiraTask {
  final String project;
  final String summary;
  final String description;

  JiraTask(
    this.project,
    this.summary,
    this.description,
  );

  Map<String, dynamic> toJson() => {
        'project': {'key': this.project},
        'summary': this.summary.replaceAll('\n', ' '),
        'description': {
          'type': 'doc',
          'version': 1,
          'content': [
            {
              'type': 'paragraph',
              'content': [
                {'text': this.description, 'type': 'text'}
              ]
            }
          ]
        },
        'issuetype': {'name': 'Task'},
      };
}

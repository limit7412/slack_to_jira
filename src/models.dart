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

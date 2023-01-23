class Feature {
  final String title, subtitle, prompt;

  Feature({
    required this.title,
    required this.subtitle,
    required this.prompt,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      title: json['title'],
      subtitle: json['subtitle'],
      prompt: json['prompt'],
    );
  }
}

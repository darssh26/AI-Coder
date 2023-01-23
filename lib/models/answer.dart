class Answer {
  final String model, text, finishReason;
  final int totalTokens;

  Answer({
    required this.model,
    required this.text,
    required this.finishReason,
    required this.totalTokens,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      model: json['model'],
      text: json['choices'][0]['text'],
      finishReason: json['choices'][0]['finish_reason'],
      totalTokens: json['usage']['total_tokens'],
    );
  }
}

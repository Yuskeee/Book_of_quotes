class Quote {
  final String text;
  final String author;

  const Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      // text: '',
      // author: '',
      text: json['content'],
      author: ((json['author'] != null) ? json['author'] : 'Unknown'),
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quote && other.text == text && other.author == author;
  }

  @override
  int get hashCode => text.hashCode ^ author.hashCode;
}

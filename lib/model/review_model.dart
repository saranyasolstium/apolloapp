class Review {
  final String name;
  final String email;
  final String reviewedAt;
  final double rating;
  final String review;

  Review({
    required this.name,
    required this.email,
    required this.reviewedAt,
    required this.rating,
    required this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    double parsedRating = json['rating'] is int
        ? (json['rating'] as int).toDouble()
        : json['rating'] as double;

    return Review(
      name: json['name'],
      email: json['email'],
      reviewedAt: json['reviewed_at'] ?? '',
      rating: parsedRating,
      review: json['review'],
    );
  }
}

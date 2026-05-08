class IdeaModel {
  final String id;
  final String title;
  final String description;
  final String creatorName;
  final String creatorInitials;
  final int likes;
  final String category;
  final String timeAgo;

  const IdeaModel({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorName,
    required this.creatorInitials,
    required this.likes,
    required this.category,
    required this.timeAgo,
  });
}

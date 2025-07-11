class PostEntity {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final PostType type;
  final PostStatus status;
  final String userId;
  final String userContact;
  final DateTime createdAt;

  PostEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.type,
    required this.status,
    required this.userId,
    required this.userContact,
    required this.createdAt,
  });
}

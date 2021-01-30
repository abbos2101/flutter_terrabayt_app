class PostModel {
  const PostModel({
    this.id,
    this.title,
    this.excerpt,
    this.content,
    this.publishedAt,
    this.updatedAt,
    this.postId,
    this.postModified,
    this.categoryId,
    this.categoryName,
    this.image,
    this.url,
    this.priority,
    this.order,
  });

  final int id;
  final String title;
  final String excerpt;
  final String content;
  final int publishedAt;
  final int updatedAt;
  final String postId;
  final String postModified;
  final int categoryId;
  final String categoryName;
  final String image;
  final String url;
  final String priority;
  final String order;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        excerpt: json["excerpt"],
        content: json["content"],
        publishedAt: json["published_at"],
        updatedAt: json["updated_at"],
        postId: json["post_id"],
        postModified: json["post_modified"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        image: json["image"],
        url: json["url"],
        priority: json["priority"],
        order: json["order"],
      );
}

class CategoryModel {
  const CategoryModel({this.id, this.name, this.slug, this.child});

  final int id;
  final String name;
  final String slug;
  final List<ItemCategory> child;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        child: json["child"] == null
            ? null
            : List<ItemCategory>.from(
                json["child"].map((x) => ItemCategory.fromJson(x)),
              ),
      );
}

class ItemCategory {
  const ItemCategory({this.id, this.name, this.slug});

  final int id;
  final String name;
  final String slug;

  factory ItemCategory.fromJson(Map<String, dynamic> json) =>
      ItemCategory(id: json["id"], name: json["name"], slug: json["slug"]);
}

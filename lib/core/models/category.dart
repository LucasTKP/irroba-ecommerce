class CategoryModel {
  final String name;

  CategoryModel({
    required this.name,
  });

  factory CategoryModel.fromJson(String name) {
    return CategoryModel(
      name: name,
    );
  }

  @override
  String toString() => 'CategoriesModel(name: $name)';
}

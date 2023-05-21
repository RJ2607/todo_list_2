class Category {
  late String name;
  late String description;

  categoryMap() {
    var mapping = Map<String, dynamic>();

    mapping["name"] = name;
    mapping["description"] = description;

    return mapping;
  }
}

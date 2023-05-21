import 'package:project/models/category.dart';
import 'package:project/repositories/repository.dart';

class CategoryService {
  late repository _repository;

  CategoryService() {
    _repository = repository();
  }

  //create data
  saveCategory(Category category) async {
    return await _repository.insertData("category", category.categoryMap());
  }

  //read data
  readCategory() async {
    return await _repository.readDate("category");
  }
}

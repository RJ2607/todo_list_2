import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/models/category.dart';
import 'package:project/screens/home_screen.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categorynamecontroller = TextEditingController();
  var _categorydescriptioncontroller = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = <Category>[];

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category["name"];
        categoryModel.description = category["description"];
        _categoryList.add(categoryModel);
      });
    });
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
              ),
              TextButton(
                onPressed: () async {
                  _category.name = _categorynamecontroller.text;
                  _category.description = _categorydescriptioncontroller.text;

                  var result = await _categoryService.saveCategory(_category);
                  print(result);
                },
                child: Text("Save"),
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightGreen),
              )
            ],
            title: Text('Categories form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categorynamecontroller,
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _categorydescriptioncontroller,
                    decoration: InputDecoration(
                      hintText: "Write a description",
                      labelText: "Description",
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text("Categories"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 6,
                child: ListTile(
                  leading: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_categoryList[index].name),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ]),
                  subtitle: Text(_categoryList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

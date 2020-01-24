import 'package:flutter/material.dart';
import 'package:buy_natural/models/category_model.dart';
import 'package:buy_natural/ui/pages/category_page.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CategoryPage(category)));
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category.title,
              style: TextStyle(
                  backgroundColor: Colors.green,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          height: 190.0,
          width: MediaQuery.of(context).size.width - 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              image: DecorationImage(
                  image: new NetworkImage(category.icon), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

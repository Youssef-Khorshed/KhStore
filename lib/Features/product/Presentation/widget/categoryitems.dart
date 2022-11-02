import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';

class CategoryItems extends StatelessWidget {
  List<InsideData> items;
  CategoryItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${items[index].name}'),
          );
        },
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../Core/ReuseableComponent/networkimage.dart';
import '../../../Logic/bloc/productBloc/prodcuts_bloc.dart';

class HomeCategories extends StatelessWidget {
  ProdcutsBloc bloc;
  HomeCategories({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: bloc.categories.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    bloc.add(GetCategoryEvent(
                        title: bloc.categories[index].name,
                        id: bloc.categories[index].id));
                  },
                  child: Column(
                    children: [
                      image(
                          url: bloc.categories[index].image,
                          width: 100,
                          height: 100),
                      Text(bloc.categories[index].name)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

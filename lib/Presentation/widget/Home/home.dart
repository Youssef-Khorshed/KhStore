import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Presentation/Logic/bloc/prodcuts_bloc.dart';
import 'package:store/Presentation/widget/Home/post_add_update_page.dart';
import 'package:store/Presentation/widget/Home/post_list_widget.dart';
import '../../../Core/ReuseableComponent/navigation.dart';
import 'loading_widget.dart';
import 'message_display_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          navigation(
              context: context,
              page: const ProductAddUpdatePage(
                isUpdateProduct: false,
              ));
        }),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ProdcutsBloc, ProdcutsState>(
            builder: (context, state) {
              if (state is LoadingProducts) {
                return const LoadingWidget();
              } else if (state is GetProdcutsSuccess) {
                return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: PostListWidget(posts: state.products));
              } else if (state is GetProdcutsFail) {
                return MessageDisplayWidget(message: state.message);
              }
              return const LoadingWidget();
            },
          ),
        ));
  }

  _onRefresh(BuildContext context) {
    BlocProvider.of<ProdcutsBloc>(context).add(GetProdcutsEvent());
  }
}

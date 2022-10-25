import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Presentation/Logic/bloc/prodcuts_bloc.dart';
import 'package:store/Presentation/widget/Home/home.dart';
import '../../../Core/ReuseableComponent/snackbar_message.dart';
import 'form_widget.dart';

class ProductAddUpdatePage extends StatelessWidget {
  // final Product post;
  final bool isUpdateProduct;
  const ProductAddUpdatePage({Key? key, required this.isUpdateProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(isUpdateProduct ? "Edit Product" : "Add Product"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<ProdcutsBloc, ProdcutsState>(
            listener: (context, state) {
              if (state is Add_Update_Delete_ProductSuccess) {
                SnackBarMessage.showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Home()),
                    (route) => false);
              } else if (state is Add_Update_Delete_ProductFail) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingProducts) {
                return const Center(child: CircularProgressIndicator());
              }

              return FormWidget(isUpdatePost: isUpdateProduct);
            },
          )),
    );
  }
}

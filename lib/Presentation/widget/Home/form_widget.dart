import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Domain/Entities/Categoty.dart';
import 'package:store/Domain/Entities/products.dart';
import 'package:store/Presentation/Logic/bloc/prodcuts_bloc.dart';

import '../../../Core/ReuseableComponent/form_submit_btn.dart';
import '../../../Core/ReuseableComponent/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Product? post;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Product(
          id: 200,
          title: _titleController.text,
          description: _bodyController.text,
          images: [],
          price: 100,
          category: const Category(id: 5, image: '', name: 'Others'));

      if (widget.isUpdatePost) {
        BlocProvider.of<ProdcutsBloc>(context)
            .add(AddProductEvent(product: post));
      } else {
        BlocProvider.of<ProdcutsBloc>(context)
            .add(UpdateProductEvent(product: post));
      }
    }
  }
}

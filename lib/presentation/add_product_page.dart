import 'package:fic5_bloc_ecatalog/bloc/update_product/update_product_bloc.dart';
import 'package:fic5_bloc_ecatalog/model/request/product_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () async {},
                  child: const Text('Camera')),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {},
                child: const Text(
                  "Galery",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
              labelText: "Price",
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Description",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocListener<UpdateProductBloc, UpdateProductState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  success: (model) {
                    Navigator.pop(context);
                  });
            },
            child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return ElevatedButton(
                      onPressed: () {
                        final model = ProductRequestModel(
                          title: titleController!.text,
                          price: int.parse(priceController!.text),
                          description: descriptionController!.text,
                        );
                        context
                            .read<UpdateProductBloc>()
                            .add(UpdateProductEvent.doUpdate(model));
                      },
                      child: const Text("Submit"),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fic5_bloc_ecatalog/bloc/add_product/add_product_bloc.dart';
import 'package:fic5_bloc_ecatalog/bloc/products/products_bloc.dart';
import 'package:fic5_bloc_ecatalog/data/datasources/local_datasource.dart';
import 'package:fic5_bloc_ecatalog/model/request/product_request_model.dart';
import 'package:fic5_bloc_ecatalog/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () async {
              await LocalDataSource().removeToken();
              Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return const LoginPage();
                },
              ));
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        state.data.reversed.toList()[index].title ?? '-',
                      ),
                      subtitle: Text('${state.data[index].price}\$'),
                    ),
                  );
                },
                itemCount: state.data.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Product"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "Title"),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Price"),
                      controller: priceController,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      controller: descriptionController,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  BlocConsumer<AddProductBloc, AddProductState>(
                    listener: (context, state) {
                      if (state is AddProductSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Add Product Success"),
                          ),
                        );
                        context.read<ProductsBloc>().add(
                              GetProductsEvent(),
                            );
                        titleController!.clear();
                        priceController!.clear();
                        descriptionController!.clear();
                        Navigator.pop(context);
                      }
                      if (state is AddProductError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Add Product ${state.message}"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AddProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ElevatedButton(
                        onPressed: () {
                          final model = ProductRequestModel(
                            title: titleController!.text,
                            price: int.parse(priceController!.text),
                            description: descriptionController!.text,
                          );
                          context
                              .read<AddProductBloc>()
                              .add(DoAddProductEvent(model: model));
                        },
                        child: const Text("Add"),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

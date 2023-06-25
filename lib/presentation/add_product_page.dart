import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fic5_bloc_ecatalog/model/request/product_request_model.dart';
import 'package:fic5_bloc_ecatalog/presentation/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/update_product_cubit/update_product_cubit.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  XFile? picture;

  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      picture = photo;
      setState(() {});
    }
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
          picture != null
              ? SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.file(
                    File(picture!.path),
                  ),
                )
              : Container(
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
                  onPressed: () async {
                    await availableCameras().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CameraPage(
                              takePicture: takePicture,
                              cameras: value,
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text('Camera')),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
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

          // Bloc

          // BlocListener<UpdateProductBloc, UpdateProductState>(
          //   listener: (context, state) {
          //     state.maybeWhen(
          //         orElse: () {},
          //         success: (model) {
          //           Navigator.pop(context);
          //         });
          //   },
          // child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
          //   builder: (context, state) {
          //     return state.maybeWhen(
          //       orElse: () {
          //         return ElevatedButton(
          //           onPressed: () {
          //             final model = ProductRequestModel(
          //               title: titleController!.text,
          //               price: int.parse(priceController!.text),
          //               description: descriptionController!.text,
          //             );
          //             context
          //                 .read<UpdateProductBloc>()
          //                 .add(UpdateProductEvent.doUpdate(model));
          //           },
          //           child: const Text("Submit"),
          //         );
          //       },
          //       loading: () {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       },
          //     );
          //   },
          // ),

          // Cubit

          BlocListener<UpdateProductCubit, UpdateProductStateCubit>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  success: (model) {
                    debugPrint(model.toString());
                    Navigator.pop(context);
                  });
            },
            child: BlocBuilder<UpdateProductCubit, UpdateProductStateCubit>(
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
                        context.read<UpdateProductCubit>().addProduct(model);
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

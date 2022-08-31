import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/data/models/category.dart';
import 'package:tameer/extensions.dart';
import 'package:tameer/logic/product/product_bloc.dart';

class HomeCategories extends StatelessWidget {
  final List<Category> categories;

  const HomeCategories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemCount: categories.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      context.read<ProductBloc>().add(ProductOpenEvent(documentId: categories[index].documentId));
                      Navigator.of(context).pushNamed('/productsList');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: categories[index].image,
                                progressIndicatorBuilder: (_, __, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                errorWidget: (_, __, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Text(categories[index].name.capitalize(), style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

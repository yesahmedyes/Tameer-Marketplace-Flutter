import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/data/models/product.dart';
import 'package:tameer/extensions.dart';
import 'package:tameer/logic/product/product_bloc.dart';
import 'package:tameer/presentation/routes.dart';
import 'package:tameer/presentation/widgets/appBars/customAppBarBack.dart';
import 'package:tameer/presentation/widgets/misc/customProgressIndicator.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void deactivate() {
    context.read<ProductBloc>().add(ProductCloseEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductOpenedState) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No products found for this category.'));
            }
            final List<Product> products = state.products;
            products.sort((a, b) => b.ordered.compareTo(a.ordered));

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 3 / 5),
                itemCount: products.length,
                itemBuilder: (ctx, index) {
                  final price = products[index].price;
                  final unit = products[index].unit;
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/productDetail', arguments: ProductDetailArguments(product: products[index], categoryId: state.categoryId));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 8,
                            child: CachedNetworkImage(
                              imageUrl: products[index].image,
                              progressIndicatorBuilder: (_, __, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                              errorWidget: (_, __, error) => const Icon(Icons.error),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(products[index].name.capitalize(), style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center, maxLines: 2),
                                const SizedBox(height: 8),
                                Text('Rs $price / $unit', style: Theme.of(context).textTheme.subtitle1),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is ProductFailedState) {
            return const Center(child: Text('An error occureed. Please try again later.'));
          }
          return const CustomProgressIndicator();
        },
      ),
    );
  }
}

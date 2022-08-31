import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/categories/categories_bloc.dart';
import 'package:tameer/logic/home/home_bloc.dart';
import 'package:tameer/logic/orders/orders_bloc.dart';
import 'package:tameer/presentation/screens/home/widgets/homeCategories.dart';
import 'package:tameer/presentation/screens/home/widgets/homeDrawer.dart';
import 'package:tameer/presentation/screens/home/widgets/homeOrders.dart';
import 'package:tameer/presentation/widgets/appBars/customAppBar.dart';
import 'package:tameer/presentation/screens/home/widgets/homeBottomAppBar.dart';
import 'package:tameer/presentation/widgets/misc/customProgressIndicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final PageController controller = PageController();

  void _onChangePage(BuildContext context) {
    if (controller.page! < 0.5) {
      context.read<HomeBloc>().add(HomeChangeToInitialEvent());
    } else if (controller.page! > 0.5) {
      context.read<HomeBloc>().add(HomeChangeToOrdersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() => _onChangePage(context));

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const HomeBottomAppBar(screen: 'home'),
      drawer: const HomeDrawer(),
      drawerEdgeDragWidth: 30,
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeInitialState && controller.page! > 0.5) {
            controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
          } else if (state is HomeOrdersState && controller.page! < 0.5) {
            controller.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
          }
        },
        child: PageView.builder(
          controller: controller,
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesInitialState) context.read<CategoriesBloc>().add(CategoriesFetchEvent());

                  if (state is CategoriesFailedState) return Center(child: Text(state.error, style: Theme.of(context).textTheme.bodyText1));

                  if (state is CategoriesSuccessState) return HomeCategories(categories: state.categories);

                  return const CustomProgressIndicator();
                },
              );
            } else {
              return BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  return const HomeOrders();
                },
              );
            }
          },
        ),
      ),
    );
  }
}

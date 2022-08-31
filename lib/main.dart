import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tameer/data/repositories/authRepository.dart';
import 'package:tameer/data/repositories/cartRepository.dart';
import 'package:tameer/data/repositories/ordersRepository.dart';
import 'package:tameer/data/repositories/productsRepository.dart';
import 'package:tameer/data/repositories/profileRepository.dart';
import 'package:tameer/logic/cart/cart_bloc.dart';
import 'package:tameer/logic/categories/categories_bloc.dart';
import 'package:tameer/logic/checkout/checkout_bloc.dart';
import 'package:tameer/logic/home/home_bloc.dart';
import 'package:tameer/logic/orders/orders_bloc.dart';
import 'package:tameer/logic/product/product_bloc.dart';
import 'package:tameer/logic/profile/profile_bloc.dart';
import 'package:tameer/logic/signup/signup_bloc.dart';
import 'package:tameer/presentation/initial.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/presentation/routes.dart';
import 'package:tameer/presentation/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepository(), lazy: false),
        RepositoryProvider<ProfileRepository>(create: (context) => ProfileRepository()),
        RepositoryProvider<ProductsRepository>(create: (context) => ProductsRepository()),
        RepositoryProvider<CartRepository>(create: (context) => CartRepository()),
        RepositoryProvider<OrdersRepository>(create: (context) => OrdersRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authRepository: context.read<AuthRepository>(),
              profileRepository: context.read<ProfileRepository>(),
            )..add(LoginCheckStatusEvent()),
            lazy: false,
          ),
          BlocProvider<SignupBloc>(create: (context) => SignupBloc(profileRepository: context.read<ProfileRepository>())..add(SignupInitializeStreamEvent())),
          BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(profileRepository: context.read<ProfileRepository>())),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<CategoriesBloc>(create: (context) => CategoriesBloc(categoryRepository: context.read<ProductsRepository>())),
          BlocProvider<ProductBloc>(create: (context) => ProductBloc(categoryRepository: context.read<ProductsRepository>())),
          BlocProvider<CartBloc>(create: (context) => CartBloc(cartRepository: context.read<CartRepository>())..add(CartCheckStatusEvent())),
          BlocProvider<CheckoutBloc>(
            create: (context) => CheckoutBloc(
              cartRepository: context.read<CartRepository>(),
              ordersRepository: context.read<OrdersRepository>(),
            )..add(const CheckoutChangeEvent()),
          ),
          BlocProvider<OrdersBloc>(create: (context) => OrdersBloc(ordersRepository: context.read<OrdersRepository>())..add(OrdersFetchEvent())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: const InitialScreen(),
        ),
      ),
    );
  }
}

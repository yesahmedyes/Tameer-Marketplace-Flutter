import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/home/home_bloc.dart';

class HomeBottomAppBar extends StatelessWidget {
  final String screen;
  const HomeBottomAppBar({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: (state is HomeInitialState) ? () {} : () => context.read<HomeBloc>().add(HomeChangeToInitialEvent()),
                  style: (state is HomeInitialState) ? null : OutlinedButton.styleFrom(primary: Colors.black54),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.home_rounded),
                      SizedBox(height: 4),
                      Text('Home', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: (state is HomeOrdersState) ? () {} : () => context.read<HomeBloc>().add(HomeChangeToOrdersEvent()),
                  style: (state is HomeOrdersState) ? null : OutlinedButton.styleFrom(primary: Colors.black54),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.assignment_outlined),
                      SizedBox(height: 4),
                      Text('Orders', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

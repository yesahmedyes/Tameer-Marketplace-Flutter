import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeChangeToInitialEvent>(_changeToInitial);
    on<HomeChangeToOrdersEvent>(_changeToOrders);
  }

  void _changeToInitial(HomeChangeToInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeInitialState());
  }

  void _changeToOrders(HomeChangeToOrdersEvent event, Emitter<HomeState> emit) {
    emit(HomeOrdersState());
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notebook/data/favitemList.dart';

part 'ecom_event.dart';
part 'ecom_state.dart';

class EcomBloc extends Bloc<EcomEvent, EcomState> {
  EcomBloc() : super(EcomState()) {
    on<FavItemEvent>(favItemfun);
    on<EcomEvent>((event, emit) {});
  }
  favItemfun(FavItemEvent event, Emitter<EcomState> emit) {
    emit(state.copyWith(
      favItemList: event.favItemList,
      discountPrice: event.discountPrice,
      mrp: event.mrp,
      totalItems: event.totalItems,
    ));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_magnit/models/filter.dart';
import 'package:flutter_magnit/models/shop.dart';
import 'package:flutter_magnit/service/shops_list.dart';

part 'shops_list_event.dart';
part 'shops_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  ShopListBloc() : super(ShopListInitial()) {
    on<GetShopsList>((event, emit) async {
      try {
        ShopsListService().initState();
        final shopList = ShopsListService().getShopsList();
        emit(ShopListLoaded(shopsList: shopList));
      } catch (e) {
        emit(ShopListFailure(exception: e));
      }
    });

    on<GetShopsListFilter>((event, emit) async {
      try {
        final shopList = ShopsListService().getFilteredShopList(event.filter);
        emit(ShopListLoaded(shopsList: shopList));
      } catch (e) {
        emit(ShopListFailure(exception: e));
      }
    });
  }
}

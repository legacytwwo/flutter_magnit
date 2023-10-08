part of 'shops_list_bloc.dart';

class ShopListState {}

class ShopListInitial extends ShopListState {}

class ShopListLoaded extends ShopListState {
  final List<ShopModel> shopsList;

  ShopListLoaded({required this.shopsList});
}

class ShopListFailure extends ShopListState {
  final Object? exception;

  ShopListFailure({required this.exception});
}

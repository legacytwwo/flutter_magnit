part of 'shops_list_bloc.dart';

class ShopListEvent {}

class GetShopsList extends ShopListEvent {}

class GetShopsListFilter extends ShopListEvent {
  final Filter filter;

  GetShopsListFilter(this.filter);
}

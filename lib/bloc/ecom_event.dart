// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ecom_bloc.dart';

@immutable
sealed class EcomEvent {}

class FavItemEvent extends EcomEvent {
  final int totalItems;
  final double mrp;
  final double discountPrice;
  final List favItemList;
  FavItemEvent({
    required this.totalItems,
    required this.mrp,
    required this.discountPrice,
    required this.favItemList,
  });
}

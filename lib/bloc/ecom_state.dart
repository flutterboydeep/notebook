// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ecom_bloc.dart';

@immutable
class EcomState {
  final int totalItems;
  final double mrp;
  final double discountPrice;
  final List favItemList;
  EcomState({
    this.discountPrice = 0.0,
    this.mrp = 0.0,
    this.favItemList = const [],
    this.totalItems = 0,
  });

  EcomState copyWith({
    int? totalItems,
    double? mrp,
    double? discountPrice,
    List? favItemList,
  }) {
    return EcomState(
      totalItems: totalItems ?? this.totalItems,
      mrp: mrp ?? this.mrp,
      discountPrice: discountPrice ?? this.discountPrice,
      favItemList: favItemList ?? this.favItemList,
    );
  }
}

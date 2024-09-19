import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ecom_bloc.dart';
import '../data/favitemList.dart';

addProductDataInCart(context, favListDataItem) {
  favItemList.add(favListDataItem);
  List<double> total = favItemList.fold([0.0, 0.0], (sum, item) {
    sum[0] += item['Mrp'];
    sum[1] += item['discountMrp'];
    return sum;
  });

  BlocProvider.of<EcomBloc>(context).add(FavItemEvent(
      totalItems: favItemList.length,
      mrp: total[0],
      discountPrice: total[1],
      favItemList: favItemList));
}

removeProductDataInCart(context, favListDataItem) {
  favItemList.remove(favListDataItem);
  List<double> total = favItemList.fold([0.0, 0.0], (sub, item) {
    sub[0] += item['Mrp'];
    sub[1] += item['discountMrp'];
    return sub;
  });

  BlocProvider.of<EcomBloc>(context).add(FavItemEvent(
      totalItems: favItemList.length,
      mrp: total[0],
      discountPrice: total[1],
      favItemList: favItemList));
}

removeCartDataWithDuplicatsValue(context, favListDataItem) {
  favItemList.removeWhere((element) => element == favListDataItem);

  List<double> total = favItemList.fold([0.0, 0.0], (sub, item) {
    sub[0] += item['Mrp'];
    sub[1] += item['discountMrp'];
    return sub;
  });

  BlocProvider.of<EcomBloc>(context).add(FavItemEvent(
      totalItems: favItemList.length,
      mrp: total[0],
      discountPrice: total[1],
      favItemList: favItemList));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebook/data/favitemList.dart';
import 'package:notebook/screens/cart_page.dart';

import '../bloc/ecom_bloc.dart';

bottomCardView(context, {required MRP, required discountMrp}) {
  return BlocBuilder<EcomBloc, EcomState>(
    builder: (context, state) {
      return state.favItemList.isNotEmpty
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                    color: Color(0xff1A95BE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Center(
                  child: BlocBuilder<EcomBloc, EcomState>(
                    builder: (context, state) {
                      return ListTile(
                        leading: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        title: Text(
                          "${state.favItemList.length} items ",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              "Rs ${state.mrp.toStringAsFixed(2)}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Rs ${state.discountPrice.toStringAsFixed(2)} ",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
                          },
                          child: Text(
                            "View cart",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff1A95BE),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : SizedBox();
    },
  );
}

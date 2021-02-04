import 'package:flutter/material.dart';
import 'package:flutter_json/models/product.dart';
import 'package:flutter_json/widgets/product_list_row.dart';

class ProductListWidget extends StatefulWidget{
  List<Product> products=new List<Product>();
  ProductListWidget(List<Product> products){
    this.products=products;
  }

  @override
  State<StatefulWidget> createState() {
    return ProductListWidgetState();
  }
}

class ProductListWidgetState extends State<ProductListWidget>{
  //products'ı direkt çekemediğimiz için State yapısına ProductListWidget ekledik.
  //products'a ulaşmak istediğmiz zaman widget.products diyerek ulaşamamız yeterlidir.

  @override
  Widget build(BuildContext context) {
    return buildProductList(context);
  }

  Widget buildProductList(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        SizedBox(
          height: 500,
          child: GridView.count(
            crossAxisCount: 2,//Her satırda kaç eleman olacağını belirlemiş oluyoruz.
            children: List.generate(
                 widget.products.length,(index){
                  return ProductListRowWidget(widget.products[index]);
                }),
          ),
        ),
      ],
    );
  }
}
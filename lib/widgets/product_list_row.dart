import 'package:flutter/material.dart';
import 'package:flutter_json/models/product.dart';

class ProductListRowWidget extends StatelessWidget{
  Product product;
  ProductListRowWidget(this.product);
  @override
  Widget build(BuildContext context) {
    return buildProductItemCard(context);
  }

  Widget buildProductItemCard(BuildContext context) {
    return InkWell(//Kartın herhangi bir yerine tıkladığımız zaman ürünün detaylarına gitmek istediğimiz için InkWell kullandık.
      child:Card(
          child:Column(
            children: <Widget>[
              Container(
                child: Image.network("https://cdn.pixabay.com/photo/2015/12/09/17/11/vegetables-1085063_960_720.jpg"),
                height: 130.0,
                width: MediaQuery.of(context).size.width/2,//Genişlik kullanılan telefonun boyutuna göre ayarlandı.
              ),
              Text(product.productName),
              Text(product.unitPrice.toString()+ " TL",style: TextStyle(fontSize: 18.0,color: Colors.blueGrey),),
            ],
          )
      )
    );
  }

}
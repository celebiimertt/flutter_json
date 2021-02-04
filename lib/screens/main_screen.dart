import 'package:flutter/material.dart';
import 'package:flutter_json/models/category.dart';
import 'package:flutter_json/models/product.dart';
import 'package:flutter_json/data/api/category_api.dart';
import 'package:flutter_json/data/api/product_api.dart';
import 'dart:convert';

import 'package:flutter_json/widgets/product_list_widget.dart';

//Herhangi bir hata yapmamanıza rağmen çalışmıyorsa terminali açıp "flutter clean" komutu ile build'i temizleyiniz.
class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }

}

class MainScreenState extends State {
  List<Category> categories=List<Category>();//Kategoriler api aracılığı ile çekmek için oluşturduk.
  List<Widget> categoryWidgets=List<Widget>();//Çektiğimiz kategoriler widget haline getirerek ekranda göstermek için oluşturduk.
  List<Product> products=List<Product>();
  @override
  void initState() {
    getCategoriesFromApi();
    getProducts();//Program ilk açıldığında bütün ürünlerin listelenmesini sağlar.
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alışveriş Sistemi", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              //Eklenen veriler telefona sığmama durumunda kaydırılabilir olmasını SingleChildScrollView() ile sağlayacağız.
              scrollDirection: Axis.horizontal,//horizontal yatay düzlem anlamında
              child: Row(
                children:categoryWidgets,
              ),

            ),
            ProductListWidget(products)
          ],
        ),
      ),
    );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((respenso){//response,getProducs()'dan gelen veriler
      setState(() {
        Iterable list=json.decode(respenso.body); // Dizi,liste gibi yapılar iterable yapılardır.
        this.categories=list.map((category)=>Category.fromJson(category)).toList();//Map ile dizinin tüm elemanlarını dolaşıp yeni bir diziye atadık.
        //category json'dan gelen data'lardır.
        //Her bir json data'sını Category nesnesine çeviriyoruz.
        //toList() ile Iterable category yerine list of category olarak şekilleniyor.
        getCategoryWidgets();
      });
    });
  }

  List<Widget> getCategoryWidgets() {
    for(int i=0;i<categories.length;i++){
      categoryWidgets.add(getCategoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  Widget getCategoryWidget(Category category) {
    return FlatButton(
      onPressed: (){
        getProductsByCategoryId(category);
        },
      child:Text(category.categoryName,style: TextStyle(color:Colors.deepPurpleAccent),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.deepOrange)
      ),
    );
  }

  void getProductsByCategoryId(Category category) {//Kategoriye ait ürünleri listeler
    ProductApi.getProductsByCategoryId(category.id).then((response){
      setState(() {
        Iterable list=json.decode(response.body);//Map formatındaki yapıyı listeye aktardık.
        this.products=list.map((product)=>Product.fromJson(product)).toList();
        /* Üst satır açıklaması:
        * Elimizdeki listeyi map ile geziyoruz.
        * Her bir product için takma isim olarak product veriyoruz.
        * Her bir product için Product sınıfının json'dan product'a çeviren Product.fromJson() metotunu çağırdık.
        * Son olarak list of producta aktarmak için Map'i listeye çevirdik.
        * */
      });
    });
  }

  void getProducts() {//Bütün ürünleri listeler
    ProductApi.getProducts().then((response){
      setState(() {
        Iterable list=json.decode(response.body);//Map formatındaki yapıyı listeye aktardık.
        this.products=list.map((product)=>Product.fromJson(product)).toList();
      });
    });
  }

}
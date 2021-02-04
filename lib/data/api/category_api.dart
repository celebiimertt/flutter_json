import 'package:http/http.dart' as http;
class CategoryApi{
  static Future getCategories(){
    //İçinde herhangi bir data tutmadığımız için static olarak oluşturduk.
    return http.get("http://10.0.2.2:3000/categories");//Emulatorun ip adresi 10.0.2.2 o yüzden localhost yazmadık.
    //Bu http adresi C:\api>json-server --watch db.json komutu ile oluşturuldu.
    //db.json dosyasını ekleyeceğim.Dosyayı C:\api bu dizine eklediğiniz takdirde yukarıda belittiğim kommutu çalışacaktır.
    // Aksi takdirde çalışmaz.
  }

}
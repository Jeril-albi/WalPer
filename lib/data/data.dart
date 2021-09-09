import 'package:wallper/model/categories.dart';

String apikey = "563492ad6f917000010000013f9cd28c64cf4adb98fdc6bf57e08908";
bool isPurchased = true;
String page = '80';

List<Categoriesmodel> getCatagories() {
  List<Categoriesmodel> catagories = new List();
  Categoriesmodel catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/348688/pexels-photo-348688.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Premium";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/697662/pexels-photo-697662.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Explore";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/40896/larch-conifer-cone-branch-tree-40896.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Nature";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/3109830/pexels-photo-3109830.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Abstract";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/1097456/pexels-photo-1097456.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Dark";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/3038740/pexels-photo-3038740.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Minimal";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  catagoriesmodel.imgurl =
      "https://images.pexels.com/photos/712618/pexels-photo-712618.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  catagoriesmodel.categoriesname = "Cars";
  catagories.add(catagoriesmodel);
  catagoriesmodel = new Categoriesmodel();

  return catagories;
}

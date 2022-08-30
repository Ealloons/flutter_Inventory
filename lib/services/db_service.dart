import 'package:last/model/products_model.dart';
import 'package:last/utils/db_helper.dart';

class DBService{
  Future<List<ProductModel>> getProducts() async{
    await DBHelper.init();

    List<Map<String,dynamic>> products =
        await DBHelper.query(ProductModel.table);
    return products.map((item) => ProductModel.fromMap(item)).toList();
  }

  Future<bool> addProduct(ProductModel model) async{
    await DBHelper.init();
    print(model.toJson());
    int ret = await DBHelper.insert(ProductModel.table,model);

    return ret == 1 ? true : false;
  }
  Future<bool> updateProduct(ProductModel model) async{
    await DBHelper.init();
    int ret = await DBHelper.update(ProductModel.table,model);
    return ret == 1 ? true : false;
  }
  Future<bool> deleteProduct(ProductModel model) async{
    await DBHelper.init();
    int ret = await DBHelper.delete(ProductModel.table,model);
    return ret == 1 ? true : false;
  }
}
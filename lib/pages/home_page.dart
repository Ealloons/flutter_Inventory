import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last/pages/add_edit_product.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:last/services/db_service.dart';
import '../model/products_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBService dbService = DBService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.blueAccent, title: const Text("목록")),
        backgroundColor: Color.fromRGBO(185, 209, 233, 1),
        body: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: FormHelper.submitButton("Search", () {
                    openDialog();
                  }, borderRadius: 10, btnColor: Colors.lightBlue,width:80),
                ),
                SizedBox(width: 160),
                Align(
                  alignment: Alignment.centerRight,
                  child: FormHelper.submitButton("Add Product", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddEditProductPage(),
                      ),
                    );
                  }, borderRadius: 10, btnColor: Colors.lightBlue),
                ),
              ],
            ),
            SizedBox(height: 10),
            _fetchData(),
          ],
        ));
  }
  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('검색'),
      content: TextField(
        decoration: InputDecoration(hintText: '물품 이름'),
      ),
      actions: [
        TextButton(onPressed: (){}, child: Text('확인'))
      ],
    )
  );
  _fetchData() {
    return FutureBuilder<List<ProductModel>>(
        future: dbService.getProducts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> products) {
          if (products.hasData) {
            return _buildDataTable(products.data!);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<ProductModel> model) {
    return ListUtils.buildDataTable(
      context,
      ["Product Name", "Price", ""],
      ["productName", "price", ""],
      false,
      0,
      model,
      (ProductModel data) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditProductPage(
                      isEditMode: true,
                      model: data,
                    )));
      },
      (ProductModel data) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("SQFLITE CRUD"),
                content: const Text("지우시겠습니까?"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormHelper.submitButton("Yes", () {dbService.deleteProduct(data).then(
                          (value){
                            setState((){
                              Navigator.of(context).pop();
                            });
                          }
                      );}),
                      const SizedBox(width: 5),
                      FormHelper.submitButton("No", () {Navigator.of(context).pop();})
                    ],
                  )
                ],
              );
            });
      },
      headingRowColor: Colors.lightBlueAccent,
      isScrollable: true,
      columnTextFontSize: 15,
      columnTextBold: false,
      columnSpacing: 50,
      onSort: (columnIndex, columnName, asc) {},
    );
  }
}

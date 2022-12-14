import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last/model/products_model.dart';
import 'package:last/services/db_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../webview/LoadFbx2.dart';



class AddEditProductPage extends StatefulWidget {
  const AddEditProductPage({Key? key,this.model,this.isEditMode=false})
      : super(key: key);
  final ProductModel? model;
  final bool isEditMode;

  @override
  State<AddEditProductPage> createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late ProductModel model;
  List<dynamic> categories = [];
  late DBService dbService;
  @override
  void initState(){
    super.initState();
    dbService = DBService();
    model = ProductModel(productName: "", categoryId: -1);
    if(widget.isEditMode){
      model=widget.model!;
    }
    categories.add({"id":1,"name":"옷장"});
    categories.add({"id":2,"name":"냉장고"});
    categories.add({"id":3,"name":"물품"});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Product' : 'Add Product')
      ),
      body: Form(
        key: globalKey,
        child: _formUI(),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
                "Save",
                    (){
                      print(model.toJson());
                      if(validateAndSave()){
                        if(widget.isEditMode){
                          dbService.updateProduct(model).then(
                              (value){
                                FormHelper.showSimpleAlertDialog(
                                    context,
                                    "SQLITE",
                                    "Data Modified Successfully",
                                    "Ok",
                                        (){
                                          Navigator.pop(context);
                                        },
                                );
                              },
                          );
                        }else{
                          dbService.addProduct(model).then(
                                (value){
                              FormHelper.showSimpleAlertDialog(
                                context,
                                "SQLITE",
                                "Data Added Successfully",
                                "Ok",
                                    (){
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        }
                      }
                    }),
            FormHelper.submitButton("Cancle", (){}),
          ],
        )
      ),
    );
  }
  _formUI(){
    return SingleChildScrollView(
      child: Column(
        children: [
          FormHelper.inputFieldWidgetWithLabel(
            context,
            "productName",
            "Product Name",
            "",
                (onValidate){
                  if(onValidate.isEmpty){
                    return "* Required";
                  }
                  return null;
                },
                (onSaved){
                  model.productName = onSaved.toString().trim();
                },
            initialValue: model.productName,
            showPrefixIcon:  true,
            prefixIcon: const Icon(Icons.text_fields),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 15,
            labelFontSize: 14,
            paddingLeft: 0,
            paddingRight: 0,
            prefixIconPaddingLeft: 10,),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    "productPrice",
                    "Product Price",
                    "",
                        (onValidate){
                      if(onValidate.isEmpty){
                        return "* Required";
                      }
                      return null;
                    },
                        (onSaved){
                      model.price = double.parse(onSaved.trim());
                    },
                    initialValue: model.price != null ? model.price.toString() : "",
                    showPrefixIcon:  true,
                    prefixIcon: const Icon(Icons.currency_rupee),
                    borderRadius: 10,
                    contentPadding: 15,
                    fontSize: 15,
                    labelFontSize: 14,
                    paddingLeft: 0,
                    paddingRight: 0,
                    prefixIconPaddingLeft: 10,
                    isNumeric: true,
                  ),
                ),
              Flexible(
                flex: 1,
                child: FormHelper.dropDownWidgetWithLabel(
                    context,
                    "Product Category",
                    "--Select--",
                    model.categoryId,
                    categories,
                    (onChanged){
                      model.categoryId = int.parse(onChanged);
                    },
                    (onValidate){},
                    labelFontSize: 14,
                    borderRadius: 10,
                    paddingRight: 0,
                    paddingLeft: 0,
                    hintFontSize: 14,
                    prefixIcon: const Icon(Icons.category),
                    showPrefixIcon:true,
                    prefixIconPaddingLeft: 10,)
              ),
            ],
          ),
          const SizedBox(height:10,),
          FormHelper.inputFieldWidgetWithLabel(
            context,
            "productDesc",
            "Product Description",
            "",
                (onValidate){
              if(onValidate.isEmpty){
                return "* Required";
              }
              return null;
            },
                (onSaved){
              model.productDesc = onSaved.toString().trim();
            },
            initialValue: model.productDesc ?? "",
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 15,
            labelFontSize: 14,
            paddingLeft: 0,
            paddingRight: 0,
            prefixIconPaddingLeft: 10,
            isMultiline: true,
            multilineRows: 5,
          ),
          const SizedBox(
            height: 10,
          ),
          _picPicker(model.productPic ?? "",
              (file)=>{
                setState(
                    (){
                      model.productPic = file.path;
                    }
                )
              }),
          const SizedBox(height:10),
        MaterialButton(onPressed: () {
          if (model.productPic != null) {
            // 화면(위젯) 이동할때 Navigator를 씀
            // image 불러오기가 성공했을때는 null이 아니므로 LoadFbx2에 넘겨
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoadFbx2(file: File(model.productPic!))));
          } else {
            print("not yet");
          }
        },child:Text('사진 모델링')
          ),
        ],
      )
    );
  }

  _picPicker(String fileName, Function onFilePicked){
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName != "" ? Image.file(File(fileName),width: 300, height: 300,)
            : const SizedBox(
            width: 350,
            height: 250,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height:35,
              width:35,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image,size:35),
                onPressed: (){
                  _imageFile=_picker.pickImage(source: ImageSource.gallery);
                  _imageFile.then((file) async{onFilePicked(file);});
                  },
              ),
            ),
            SizedBox(
              height:35,
              width:35,
              child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.camera,size:35),
              onPressed: (){
                _imageFile=_picker.pickImage(source: ImageSource.camera);
                _imageFile.then((file) async{onFilePicked(file);});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }
}

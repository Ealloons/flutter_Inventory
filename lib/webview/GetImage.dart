import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'LoadFbx2.dart';

class GetImage extends StatefulWidget {
  const GetImage({Key? key}) : super(key: key);

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  // File? image 상태 변수가 필요하기 때문에 GetImage 위젯을 StatefulWidget 으로 정의한다
  File? image;
  Future pickImage() async{
    // Image 불러오기
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch(e){
      // 실패했을 때
      print('Failed to pick image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Picker'),
        ),
        body: Center(
            child: Column(
              children: [
                MaterialButton(onPressed:(){
                  pickImage();
                },child:Text('사진 불러오기')),
                MaterialButton(onPressed:(){
                  if(image != null){
                    // 화면(위젯) 이동할때 Navigator를 씀
                    // image 불러오기가 성공했을때는 null이 아니므로 LoadFbx2에 넘겨
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoadFbx2(file:image!)));
                  }else{
                    print("not yet");
                  }
                },child:Text('image send')),
                SizedBox(height:20,width:20),
                // image가 null이 아니면 SizedBox에 띄움
                image != null? Image.file(image!) : Text("No image selected")
              ],
            )
        )
    );
  }
}

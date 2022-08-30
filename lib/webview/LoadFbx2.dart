import 'package:flutter/material.dart';
import 'package:last/webview/WebView.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert' show utf8;

class LoadFbx2 extends StatefulWidget {
  final File file;
  const LoadFbx2({required this.file});

  @override
  State<LoadFbx2> createState() => _LoadFbx2State(file:file);
}

class _LoadFbx2State extends State<LoadFbx2> {
  final File file;
  // String? url 상태 변수가 필요하기 때문에 LoadFbx2를 StatefulWidget으로 정의함
  String? url;
  _LoadFbx2State({required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
        body: Center(
          child: Column(
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: FormHelper.submitButton("이미지 보내기", () {
                getNetworkData();
              }, borderRadius: 10, btnColor: Colors.lightBlue,width:160),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: FormHelper.submitButton("모델 보기", () {
                if(url != null){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetWebView(url:url!)));
                }else{
                  print("not yet");
                }
              }, borderRadius: 10, btnColor: Colors.lightBlue,width:160),
            ),
          ]
          )
        ),

    );
  }
  // socket 전송 함수
  void getNetworkData() async {
    // message가 전송되면 이미지 전송이 끝났다는 것임
    String message = "%IMAGE_COMPLETE%";
    // byte로 변환
    List<int> message_bytes = utf8.encode(message);
    // 위에서 받아온 file 변수를 byte로 변환
    Uint8List bytes= file.readAsBytesSync();
    Socket s = await Socket.connect('192.168.35.145', 1002);

    // 밑에 정의한 sendMessage 함수는 Future타입으로 비동기로 호출된다.
    // await을 붙여주면 기다렸다가 아래 로직을 실행하는 것이고 안붙여주면 기다리지 않고 아래의 로직을 실행한다.
    await sendMessage(s, bytes);
    sendMessage(s, Uint8List.fromList(message_bytes));

    //url = await utf8.decoder.bind(s).join();

    // 서버에서 데이터를 받아온다.
    s.listen(
            (onData) {
          print("test is cool? ${String.fromCharCodes(onData).trim()}");
          setState(() {
            // 받아온 값을 url 변수에 저장한다.
            url = String.fromCharCodes(onData).trim();
          });});

    await s.close();
  }
  Future<void> sendMessage(Socket socket, Uint8List message) async {
    print('Client: $message');
    socket.add(message);
  }
}

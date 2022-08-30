# Mobile Inventory

프로젝트로 진행한 재고관리 앱입니다.
<p align="center">
<img src="./그림01.jpg" width="300" height="400">
<img src="./그림02.jpg" width="300" height="400">
<img src="./그림03.jpg" width="300" height="400">
<img src="./ezgif-4-6f4b14424a.gif" width="300" height="400">
</p>

## 개발 의의
현재 flutter에는 stl, fbx, obj 등 3d 모델링 파일 뷰어가 불안하기 때문에 이를 웹 뷰로 극복하고자 했습니다.<br>
사용자 앨범의 이미지를 소켓을 이용해 서버로 보낸 후 서버는 웹으로 3d 파일을 띄워주고 해당 url을 사용자에게 답신합니다. <br>
그리고 사용자는 웹 뷰를 통해 이미지의 3d 모델링을 볼 수 있습니다. <br>
서버는 파이썬으로 구현하였고, 모델링은 three.js 를 이용했습니다.

## 시스템 구성도
<p align="center">
<img src="./그림04.jpg" width="600" height="500">
</p>

## 참고 사항 및 출처
간단한 서버의 구현은 [파이썬 코드](https://github.com/Ealloons/flutter_Inventory/blob/master/Server/server.py, "파이썬 ") 에 있습니다. <br>
three.js : [three.js](https://threejs.org/, "파이썬 ") <br>
2d to 3d : [python]([https://threejs.org/](https://github.com/armindocachada/create-3d-model-using-python), "파이썬 ") <br>

## 소요 라이브러리
*flutter
-Web_view
-Socket_io
-image_picker
-sqflite
*Server-python
-Socket
-IO
-Threading
*Web
-Three.js
*Converter-python
-image
-Numpy

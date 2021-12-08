import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

 class _CameraPageState extends State<CameraPage> {

    List<CameraDescription> cameras;
    CameraController _cameraController;

   // late List<dynamic>? _galleryPhotos;

   @override
   void initState() {
     initializeCamera();
     super.initState();
   }

   Future<void> initializeCamera() async {
     cameras = await availableCameras();
     _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
     _cameraController.initialize().then((value) {
       if (!mounted) return;
       setState(() {

       });
     });
   }


   @override
   Widget build(BuildContext context) {
     if (_cameraController==null || !_cameraController.value.isInitialized) {
       return Container(height: 0.0, width: 0.0,);
     }
     return Scaffold(
         body: Stack(
           children: <Widget>[
             Container(
               height: double.infinity,
               width: double.infinity,
               child: CameraPreview(_cameraController),

             ),
             _cameraButtonWidget(),
             // _galleryWidget(),
           ],
         )
     );
   }

   Widget _cameraButtonWidget() {
     return Align(
       alignment: Alignment.bottomCenter,
       child: Container(
         padding: EdgeInsets.symmetric(horizontal: 10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Icon(Icons.flash_on, color: Colors.white, size: 30,),
             Container(
               height: 80,
               width: 80,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(50)),
                 border: Border.all(color: Colors.white, width: 2),
               ),
             ),
             Icon(Icons.camera_alt, size: 30, color: Colors.white,)
           ],
         ),
       ),
     );
   }
 }

  // Widget _galleryWidget() {
  //   return Positioned(
  //     bottom: 100,
  //     right: 0,
  //     left: 0,
  //     child: Container(
  //       height: 55,
  //       child: ListView.builder(
  //           itemCount: _galleryPhotos.length,
  //           itemBuilder: (_,index){
  //             return Container(
  //               child: Image.file(_galleryPhotos[index]fit:BoxFit.cover),
  //             )
  //           },
  //       ),
  //     ),
  //   )
  // }
  // }




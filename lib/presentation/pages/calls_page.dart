import 'package:flutter/material.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';

import 'sub_page/single_Item_call_page.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext cotext, int index){
            return SingleItemCallPage();
         },
      ),
          floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: primaryColor,
            child: Icon(Icons.add_call,color: Colors.white,),
    ),
    );
  }
}

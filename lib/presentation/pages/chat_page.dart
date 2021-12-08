import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendme/domain/entities/user_entity.dart';
import 'package:sendme/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:sendme/presentation/pages/sub_page/select_contact_page.dart';
import 'package:sendme/presentation/pages/sub_page/single_communication_page.dart';
import 'package:sendme/presentation/pages/sub_page/single_item_chat_user_page.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final UserEntity userInfo;

  const ChatPage({Key key, this.userInfo}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<MyChatCubit>(context).getMyChat(uid: widget.userInfo.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyChatCubit, MyChatState>(
        builder: (_, myChatState) {
          if (myChatState is MyChatLoaded) {
            return _myChatList(myChatState);
          }
          return _loadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SelectContactPage(
                    userInfo: widget.userInfo,
                  )));
        },
        child: Icon(Icons.chat),
      ),
    );
  }

  Widget _emptyListDisplayMessageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: greenColor.withOpacity(.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Icon(
            Icons.message,
            color: Colors.white.withOpacity(.6),
            size: 40,
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Start chat with your friends and family,\n on WhatsApp Clone",
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.4)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _myChatList(MyChatLoaded myChatData) {
    return myChatData.myChat.isEmpty
        ? _emptyListDisplayMessageWidget()
        : ListView.builder(
          itemCount: myChatData.myChat.length,
          itemBuilder: (_, index) {
            final myChat=myChatData.myChat[index];
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => SingleCommunicationPage(
                senderPhoneNumber: myChat.senderPhoneNumber,
                sendUID: widget.userInfo.uid,
                senderName: myChat.senderName,
                recipientUID: myChat.recipientUID,
                recipientPhoneNumber: myChat.recipientPhoneNumber,
                recipientName: myChat.recipientName,
              ),
            ));
          },
          child: SingleItemChatUserPage(
            name: myChat.recipientName,
            recentSendMessage: myChat.recentTextMessage,
            time: ""
          ),
        );
      },
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

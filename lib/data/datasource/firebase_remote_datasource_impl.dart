import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sendme/data/datasource/firebase_remote_datasource.dart';
import 'package:sendme/data/model/my_chat_model.dart';
import 'package:sendme/data/model/text_message_model.dart';
import 'package:sendme/data/model/user_model.dart';
import 'package:sendme/domain/entities/my_chat_entity.dart';
import 'package:sendme/domain/entities/text_message_entity.dart';
import 'package:sendme/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  String _verificationId = "";

  FirebaseRemoteDataSourceImpl({this.auth, this.fireStore});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");
    final uid = await getCurrentUID();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        status: user.status,
        profileUrl: user.profileUrl,
        isOnline: user.isOnline,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!userDoc.exists) {
        //create new user
        userCollection.doc(uid).set(newUser);
      } else {
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      print("phone verified : Token ${authCredential.token}");
    };
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print("time out :$verificationId");
    };
    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResendingToken]) {};
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        timeout: const Duration(seconds: 10),
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity)async {
    final myChatRef=fireStore.collection('users')
        .doc(myChatEntity.sendUID)
        .collection('myChat');

    final otherChatRef=fireStore.collection('users')
        .doc(myChatEntity.recipientUID)
        .collection('myChat');

    final myNewChat= MyChatModel(
      time: myChatEntity.time,
      senderName: myChatEntity.senderName,
      sendUID: myChatEntity.senderPhoneNumber,
      recipientUID: myChatEntity.recipientUID,
      recipientName: myChatEntity.recipientName,
      channelId: myChatEntity.channelId,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      profileURl: myChatEntity.profileURl,
      recentTextMessage: myChatEntity.recentTextMessage,
      recipientPhoneNumber: myChatEntity.recipientPhoneNumber,
      senderPhoneNumber: myChatEntity.senderPhoneNumber,
    ).toDocument();
    final otherNewChat= MyChatModel(
        time: myChatEntity.time,
        senderName: myChatEntity.recipientName,
        sendUID: myChatEntity.recipientUID,
        recipientUID: myChatEntity.sendUID,
        recipientName: myChatEntity.senderName,
        channelId: myChatEntity.channelId,
        isArchived: myChatEntity.isArchived,
        isRead: myChatEntity.isRead,
        profileURl: myChatEntity.profileURl,
        recentTextMessage: myChatEntity.recentTextMessage,
        recipientPhoneNumber: myChatEntity.senderPhoneNumber,
        senderPhoneNumber: myChatEntity.recipientPhoneNumber,
    ).toDocument();

    myChatRef.doc(myChatEntity.recipientUID).get().then((myChatDoc) {
      if (!myChatDoc.exists) {
        //Create
        myChatRef.doc(myChatEntity.recipientUID).set(myNewChat);
        otherChatRef.doc(myChatEntity.sendUID).set(otherNewChat);
        return;
      } else {
        //Update
        myChatRef.doc(myChatEntity.recipientUID).update(myNewChat);
        otherChatRef.doc(myChatEntity.sendUID).update(otherNewChat);
        return;
      }
    });
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) async {
    final userCollectionRef = fireStore.collection("user");
    final oneToOneChatChannelRef = fireStore.collection("myChatChannel");

    userCollectionRef
        .doc(uid)
        .collection("engagedChatChannel")
        .doc(otherUid)
        .get()
        .then((chatChannelDoc) {
      if (chatChannelDoc.exists) {
        return;
      }
      //if not exists
      final _chatChannelId = oneToOneChatChannelRef.doc().id;
      var channelMap = {
        "channelId": _chatChannelId,
        "channelType": "oneToOneChat",
      };
      oneToOneChatChannelRef.doc(_chatChannelId).set(channelMap);

      //currentUser
      userCollectionRef
          .doc(uid)
          .collection("engagedChatChannel")
          .doc(otherUid)
          .set(channelMap);

      //OtherUser
      userCollectionRef
          .doc(otherUid)
          .collection("engagedChatChannel")
          .doc(uid)
          .set(channelMap);

      return;
    });
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollectionRef = fireStore.collection("user");
    return userCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docQuerySnapshot) => UserModel.fromSnapshot(docQuerySnapshot))
          .toList();
    });
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final messagesRef = fireStore
        .collection("myChannel")
        .doc(channelId)
        .collection('messages');

    return messagesRef.orderBy('time').snapshots().map(
          (querySnap) => querySnap.docs
              .map((doc) => TextMessageModel.fromSnapShot(doc))
              .toList(),
        );
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    final myChatRef =
    fireStore.collection('users').doc(uid).collection('myChat');

    return myChatRef.orderBy('time', descending: true).snapshots().map(
          (querySnap) => querySnap.docs
          .map((doc) => MyChatModel.fromSnapShot(doc))
          .toList(),
    );
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid) {
    final userCollectionRef = fireStore.collection('user');
    return userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannel) {
      if (engagedChatChannel.exists) {
        return engagedChatChannel.data()['channelId'];
      }
      return Future.value(null);
    });
  }

  @override
  Future<void> sendTextMessage(
    TextMessageEntity textMessageEntity,
    String channelId,
  ) async {
    final messageRef = fireStore
        .collection('myChannel')
        .doc('channelID')
        .collection('messages');

    final messageId = messageRef.doc().id;

    final newMessage = TextMessageModel(
      message: messageId,
      messageId: messageId,
      messageType: textMessageEntity.messageType,
      recipientName: textMessageEntity.recipientName,
      recipientUID: textMessageEntity.sendUID,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
    ).toDocumen();

    messageRef.doc(messageId).set(newMessage);
  }
}

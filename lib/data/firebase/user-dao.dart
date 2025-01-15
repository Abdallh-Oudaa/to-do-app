import 'package:app_to_do/data/model/user-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
static CollectionReference<UserModel> getUserCollection(){
  return  FirebaseFirestore.instance.collection(UserModel.collectionName).
    withConverter(fromFirestore: (snapshot, options) => UserModel.fromFireStore(snapshot.data()??{}),
        toFirestore:(userModel, options) => userModel.toFireStore());
  }
static Future<void> addUserToFireStore(UserModel user)async {
  DocumentReference<UserModel>dbDocument= getUserCollection().doc(user.id);

 await dbDocument.set(user);
  }
 static Future<UserModel?> getUserFromFireStore(String uid)async{
 DocumentReference<UserModel> dbDocument= getUserCollection().doc(uid);

 DocumentSnapshot<UserModel> snapshot=await dbDocument.get();
 return snapshot.data();


  }
}
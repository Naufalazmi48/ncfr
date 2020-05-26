import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static CollectionReference customers =
      Firestore.instance.collection("Customer");

  static Future<DocumentSnapshot> checkData(String email) async {
    return await customers.document(email.toLowerCase()).get();
  }

  static Future<void> resetPoin(String email) async{
    await customers.document(email.toLowerCase()).setData(
      {
        "Poin" : 0
      },merge: true
    );
  }
}

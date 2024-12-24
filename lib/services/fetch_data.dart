import 'package:cloud_firestore/cloud_firestore.dart';

List<Map<String , dynamic>> data = [];

Future<void> fetchData() async {

  try{

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    data = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    print(snapshot.docs);
    print(data);
  }catch(e){

    print("error : $e");
    data = [];

  }


}

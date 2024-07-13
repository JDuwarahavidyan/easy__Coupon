import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


User? currentUser;

void initState() {
  //super.initState();
  currentUser = FirebaseAuth.instance.currentUser;
}

create(String email, name, picture, int count) async {
  await FirebaseFirestore.instance.collection('students').doc(email).set({
    'name': name,
    'count': count,
    'picture': picture,
  });

  print('database Updated');
}

update(String colName, docName, field, var newField) async {
  await FirebaseFirestore.instance
      .collection(colName)
      .doc(docName)
      .update({field: newField});

  print('field updated');
}

Future<void> updateCount(int val,String userId) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId);

    // Get the document snapshot
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final currentCount = data?['studentCount'];

      // Check if currentCount is less than 30
      if (currentCount != null &&
          currentCount <= 30 &&
          currentCount + val > 0) {
        // Update the count field
        await docRef.update({'studentCount': FieldValue.increment(-val)});
        print('Document updated');
      } else {
        print('Reached maximum token');
      }
    } else {
      print('Document does not exist');
  }
}

void scanned_data(Barcode result, int val,String userId) {
  print("data:${result.code}");
  //print(currentUser!.uid.toString());
  updateCount(val,userId);
}

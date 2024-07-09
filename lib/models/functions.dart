

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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



Future<void> updateCount(int val) async {
  final docRef = FirebaseFirestore.instance
      .collection('students')
      .doc('student@ruhuna.com');

  // Get the document snapshot
  final snapshot = await docRef.get();

  if (snapshot.exists) {
    final data = snapshot.data();
    final currentCount = data?['count'];

    // Check if currentCount is less than 30
    if (currentCount != null &&
        currentCount <= 30 &&
        currentCount + val <= 30) {
      // Update the count field
      await docRef.update({'count': FieldValue.increment(val)});
      print('Document updated');
    } else {
      print('Reached maximum token');
    }
  } else {
    print('Document does not exist');
  }
}


void scanned_data( Barcode result){  
  print("data:${result.code}");
}
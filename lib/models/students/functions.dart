import 'package:cloud_firestore/cloud_firestore.dart';

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

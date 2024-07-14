import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

Future<bool> uploadImage({
  required File filePathToUpload,
  required String userId,
}) =>
    FirebaseStorage.instance
        .ref(userId)
        .child(
          const Uuid().v4(),
        )
        .putFile(filePathToUpload)
        .then((task) => task.state == TaskState.success)
        .catchError((error) {
      debugPrint('Error uploading image: $error');
      return false;
    });

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Constants/Posts/user_pay_load.dart';

@immutable
class SaveUserInfoStorage {
  const SaveUserInfoStorage();

  Future<bool> saveInfo({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(CollectionNames.users)
          .where(
            FirebaseFieldNames.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldNames.email: email ?? '',
          FirebaseFieldNames.displayName: displayName,
        });
        return true;
      }

      final payLoad = UserInfoPayLoad(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await FirebaseFirestore.instance.collection(CollectionNames.users).add(
            payLoad,
          );

      return true;
    } catch (e) {
      return false;
    }
  }
}

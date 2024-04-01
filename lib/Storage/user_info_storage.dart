import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Constants/Posts/user_pay_load.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String email,
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
          FirebaseFieldNames.displayName: displayName,
          FirebaseFieldNames.email: email,
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
    } catch (e) {
      return false;
    }
    return false;
  }
}

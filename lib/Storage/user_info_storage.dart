import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          .collection(FirebaseFieldNames.users)
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
      final payLoad = UserPayLoad(
        userId: userId,
        email: email,
        displayName: displayName,
      );

      await FirebaseFirestore.instance.collection(FirebaseFieldNames.users).add(
            payLoad,
          );
      return true;
    } catch (e) {
      return false;
    }
  }
}

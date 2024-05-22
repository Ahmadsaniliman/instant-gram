import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Widgets/UserModel/user_modell.dart';

final userModelProvider = StreamProvider.family.autoDispose<UserModel, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<UserModel>();

    final sub = FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .where(FirebaseFieldNames.users, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        final doc = snapshot.docs.first;
        final json = doc.data();
        final userModel = UserModel.fromJson(json, userId);
        controller.add(userModel);
      },
    );

    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);

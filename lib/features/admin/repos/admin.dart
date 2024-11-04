// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/models/member.dart';
import 'package:nexus_ranking_system/utils/messengers.dart';

class AdminRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> createField(BuildContext context,{required String name}) async {
    try {
      await _firestore.collection('fields').add(
        Field(name: name).toJson()
      );
    } catch (e) {
      Messengers.showSnackBar(context, message: e.toString());
    }
  }

  Future<void> updateField(BuildContext context,String id,{required String newFieldName}) async {
    try {
      await _firestore.collection('fields').doc(id).update({
        'name': newFieldName
      });
    } catch (e) {
      Messengers.showSnackBar(context, message: e.toString());
    }
  }

  Future<void> deleteField(BuildContext context,String id) async {
    try {
      await _firestore.collection('fields').doc(id).delete();
    } catch (e) {
      Messengers.showSnackBar(context, message: e.toString());
    }
  }

  Future<void> updateUserScore(BuildContext context, {required String userId, required String fieldId, required int newScore}) async {
    try {
      final userDoc = await _firestore.collection('members').doc(userId).get();
      if (!userDoc.exists) throw Exception('User not found');

      List<dynamic> scores = userDoc.data()?['scores'] ?? [];
      bool updated = false;

      scores = scores.map((scoreJson) {
        final scoreMap = Map<String, dynamic>.from(scoreJson);
        if (scoreMap['field'] == fieldId) {
          scoreMap['points'] = newScore;
          updated = true;
        }
        return scoreMap;
      }).toList();

      if (!updated) {
        scores.add({'field': fieldId, 'points': newScore});
      }

      await _firestore.collection('members').doc(userId).update({'scores': scores});
    } catch (e) {
      Messengers.showSnackBar(context, message: e.toString());
    }
  }
}

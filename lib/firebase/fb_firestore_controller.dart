import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/FB_AucationModel.dart';

typedef FirestoreEvent = void Function(bool status);

class FbFireStoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getAucationLastBid({required int aucationID}) {
    return _firebaseFirestore
        .collection('Aucations')
        .doc('${aucationID}')
        .snapshots();
  }

  Future<bool> AddNewBid({
    required num aucationID,
    required num BidAmount,
  }) async {
    bool responce =
        await _firebaseFirestore.collection('Aucations').doc('${aucationID}').set({
      'aucationID': aucationID,
      'lastPrice': BidAmount,
    }).then((value) {

      return true;
    }).catchError((error) {
      return false;
    });
    return responce;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteBloc {
  final CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection('favorites');

  Future<void> toggleFavorite(String userId, String productId) async {
    DocumentSnapshot favoriteDoc = await favoriteCollection
        .doc(userId)
        .collection('products')
        .doc(productId)
        .get();

    if (favoriteDoc.exists) {
      await favoriteDoc.reference.delete();
    } else {
      await favoriteDoc.reference.set({'favorite': true});
    }
  }

  Future<bool> isFavorite(
    String userId,
    String productId,
  ) async {
    DocumentSnapshot favoriteDoc = await favoriteCollection
        .doc(userId)
        .collection('products')
        .doc(productId)
        .get();

    return favoriteDoc.exists;
  }
}

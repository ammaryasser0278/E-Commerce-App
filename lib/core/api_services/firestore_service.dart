import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    "products",
  );

  // 🔹 Add product
  Future<void> addProduct(
    String image,
    String name,
    double price,
    double rating,
    String desc,
  ) async {
    await products.add({
      "image": image,
      "name": name,
      "price": price,
      "rating": rating,
      "desc": desc,
      "createdAt": DateTime.now(),
    });
  }

  // 🔹 Get products (once)
  Future<List<Map<String, dynamic>>> getProductsOnce() async {
    var snapshot = await products.get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // 🔹 Stream products (realtime)
  Stream<QuerySnapshot> getProductsStream() {
    return products.orderBy("createdAt", descending: true).snapshots();
  }

  // 🔹 Update product
  Future<void> updateProduct(String docId, Map<String, dynamic> data) async {
    await products.doc(docId).update(data);
  }

  // 🔹 Delete product
  Future<void> deleteProduct(String docId) async {
    await products.doc(docId).delete();
  }
}

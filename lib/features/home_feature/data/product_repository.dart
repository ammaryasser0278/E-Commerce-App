import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supplements_app/features/home_feature/data/product_model.dart';

class ProductRepository {
  final CollectionReference<Map<String, dynamic>> _products;

  ProductRepository({FirebaseFirestore? firestore})
    : _products = (firestore ?? FirebaseFirestore.instance)
          .collection('products')
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snapshot, _) => snapshot.data() ?? {},
            toFirestore: (data, _) => data,
          );

  Future<void> seedFakeProductsIfEmpty() async {
    final existingSnap = await _products.get();

    final List<Map<String, dynamic>> seed = [
      {
        'image': 'https://m.media-amazon.com/images/I/71OsEAdPuZL.jpg',
        'name': 'Whey Protein Powder',
        'price': 29.99,
        'rating': 4.5,
        'type': 'Protein',
        'desc':
            'Whey Protein Powder عالي الجودة يحتوي على بروتين سريع الامتصاص لدعم نمو العضلات، تحسين التعافي بعد التمارين، وزيادة القوة. مناسب للاعبي كمال الأجسام والرياضيين بشكل عام.',
        'createdAt': DateTime.now(),
      },
      {
        'image':
            'https://aavalabs.com/cdn/shop/files/Multivitamin_EN_with_Box_v2_1.png?v=1756988039&width=2048',
        'name': 'Multivitamin Complex',
        'price': 19.99,
        'rating': 4.2,
        'type': 'Vitamins',
        'desc':
            'مكمل غذائي يحتوي على مجموعة متكاملة من الفيتامينات والمعادن الأساسية لدعم صحة الجسم، تعزيز المناعة، وتحسين مستويات الطاقة اليومية.',
        'createdAt': DateTime.now(),
      },
      {
        'image': 'https://ifit-eg.com/wp-content/uploads/2024/05/Omega.png',
        'name': 'Omega-3 Fish Oil',
        'price': 24.99,
        'rating': 4.7,
        'type': 'Omega-3',
        'desc':
            'مكمل زيت السمك الغني بـ EPA و DHA لدعم صحة القلب والأوعية الدموية، تحسين وظائف الدماغ، والمساهمة في مرونة المفاصل وصحة العظام.',
        'createdAt': DateTime.now(),
      },
      {
        'image':
            'https://www.confidenthealth.com/cdn/shop/files/CS1004-Creatine-Mono-450g-87440400023-front_1024x1024.jpg?v=1726163940',
        'name': 'Creatine Monohydrate',
        'price': 21.99,
        'rating': 4.6,
        'type': 'Creatine',
        'desc':
            'كرياتين مونوهيدرات النقي يساعد على زيادة القوة، تحسين الأداء في التمارين عالية الكثافة، وتسريع عملية استشفاء العضلات. من أكثر المكملات بحثًا وفعالية.',
        'createdAt': DateTime.now(),
      },
      {
        'image':
            'https://i5.walmartimages.com/seo/Women-s-Best-BCAA-Amino-Acids-Powder-Peach-Ice-Tea-150g-5-3-oz_e500a44f-e327-48c1-b16a-91ba2f45eab6.cd3ccf74bee756667b93a9bd442711d3.jpeg',
        'name': 'BCAA Amino Acids',
        'price': 17.99,
        'rating': 4.3,
        'type': 'Amino Acids',
        'desc':
            'أحماض أمينية متشعبة السلسلة (BCAA) لدعم منع تكسير العضلات، تعزيز الطاقة أثناء التمارين، وتسريع عملية الاستشفاء العضلي بعد التدريب الشاق.',
        'createdAt': DateTime.now(),
      },
      {
        'image':
            'https://m.media-amazon.com/images/I/712rBvBFubL._UF1000,1000_QL80_.jpg',
        'name': 'Pre-Workout Booster',
        'price': 27.99,
        'rating': 4.4,
        'type': 'Pre-Workout',
        'desc':
            'مكمل قبل التمرين يحتوي على مزيج من الكافيين، البيتا ألانين، والـ L-Arginine لزيادة الطاقة، تحسين التركيز، وزيادة ضخ الدم للعضلات أثناء التدريب.',
        'createdAt': DateTime.now(),
      },
      {
        'image':
            'https://proteinmalta.com/wp-content/uploads/2023/03/zma-complex.jpg',
        'name': 'ZMA Complex',
        'price': 15.99,
        'rating': 4.1,
        'type': 'Minerals',
        'desc':
            'مكمل يحتوي على الزنك، المغنيسيوم، وفيتامين B6، يساعد في تحسين جودة النوم، دعم إنتاج التستوستيرون، وتسريع عملية الاستشفاء العضلي.',
        'createdAt': DateTime.now(),
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyKUpF4_0wicWDwbDd333WtRrHSbeSu5yWLg&s',
        'name': 'Casein Protein',
        'price': 31.99,
        'rating': 4.5,
        'type': 'Protein',
        'desc':
            'كازين بروتين بطيء الامتصاص مثالي للاستخدام قبل النوم للحفاظ على تغذية العضلات لساعات طويلة، ومنع التكسير العضلي أثناء فترات الصيام أو النوم.',
        'createdAt': DateTime.now(),
      },
    ];
    // If collection is empty or missing some seeded items, top it up.
    if (existingSnap.docs.length < seed.length) {
      final existingNames = existingSnap.docs
          .map((d) => (d.data()['name'] ?? '').toString())
          .toSet();

      final toAdd = seed
          .where((item) => !existingNames.contains(item['name']))
          .toList();
      if (toAdd.isEmpty) return;

      final batch = _products.firestore.batch();
      for (final data in toAdd) {
        final doc = _products.doc();
        batch.set(doc, data);
      }
      await batch.commit();
    }
  }

  Stream<List<Product>> streamProducts() {
    return _products
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Product.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<List<Product>> fetchProductsOnce() async {
    final snap = await _products.orderBy('createdAt', descending: true).get();
    return snap.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }
}

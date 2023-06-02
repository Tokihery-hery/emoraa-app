class Housse {
  final int? id;
  final int? ownerId;
  late final String title;
  late final int price;
  late final String descrption;
  late final int chCount;
  late final String? createdAt;
  final int? hasWC;
  final int? hasDouche;
  final int? hasChecken;

  Housse({
    this.id,
    this.ownerId,
    required this.title,
    required this.price,
    required this.descrption,
    required this.chCount,
    this.createdAt,
    this.hasWC,
    this.hasDouche,
    this.hasChecken,
  });
  Map<String, dynamic> toMap() => {
        'owner_id': ownerId,
        'title': title,
        'price': price,
        'description': descrption,
        'ch_count': chCount,
        'created_at': createdAt.toString(),
        'has_wc': hasWC,
        'has_douche': hasDouche,
        'has_checken': hasChecken
      };

  factory Housse.fromString(Map<String, dynamic> value) => Housse(
        id: value['id'],
        title: value['title'],
        price: value['price'] ?? 0,
        descrption: value['description'],
        chCount: value['chCount'] ?? 0,
        createdAt: value['created_at'].toString(),
        hasChecken: value['has_checken']?? 0,
        hasDouche: value['has_douche'] ?? 0,
        hasWC: value['has_wc'] ?? 0
      );
}

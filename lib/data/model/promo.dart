class Promo {
  Promo({
    required this.id,
    required this.description,
    required this.discount,
    required this.limit,
    required this.available,
  });
  late final String id;
  late final String description;
  late final int discount;
  late final int limit;
  late final bool available;

  Promo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    discount = json['discount'];
    limit = json['limit'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['discount'] = discount;
    data['limit'] = limit;
    data['available'] = available;
    return data;
  }
}


class Product {
  final int id;
  final String name;
  final int price;
  final String barcode;

  Product(this.id, this.name, this.price, this.barcode);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json["id"],
      json["name"],
      json["price"],
      json["barcode"] ?? "",
    );
  }
}
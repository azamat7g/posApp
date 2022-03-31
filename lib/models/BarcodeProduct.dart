
class BarcodeProduct {
  final String name;
  final String barcode;

  BarcodeProduct(this.name, this.barcode);

  factory BarcodeProduct.fromJson(Map<String, dynamic> json) {
    return BarcodeProduct(
      json["name"],
      json["barcode"].toString(),
    );
  }
}
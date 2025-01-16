
class CarVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  int availability;
  Map<String, String> attributeValues;

  CarVariationModel({
    required this.id,
    this.image = '',
    this.sku = '',
    this.description = '',
    this.price = 0.0,
    this.availability = 0,
    required this.attributeValues,
});

  ///creating empty function for clean code
 static CarVariationModel empty() => CarVariationModel(id: '', attributeValues: {});

  ///Json format
  toJson() {
    return {
     'Id': id,
     'Image': image,
     'Description' : description,
      'Price': price,
      'SKU' : sku,
      'Availability' : availability,
      'AttributeValues': attributeValues,
    };
  }

  ///Mapping Json oriented document snapshot from firebase to usermodel
  factory CarVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if(data.isEmpty) return CarVariationModel(id: '', attributeValues: {});

    return CarVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      availability: data['Availability'] ?? 0,
      image: data['Image'] ?? '',
      attributeValues: Map<String,String>.from(data['AttributeValues']),

    );
  }
}
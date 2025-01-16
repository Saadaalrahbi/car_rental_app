
class CarAttributeModel {
  String? name;
  final List<String>? values;

  CarAttributeModel({this.name, this.values});

  ///Json format
 toJson() {
   return {'Name' : name, 'Values': values};
 }

///Mapping Json oriented document snapshot from firebase to usermodel
 factory CarAttributeModel.fromJson(Map<String, dynamic> document) {
   final data = document;

   if(data.isEmpty) return CarAttributeModel();

   return CarAttributeModel(
     name: data.containsKey('Name') ? data['Name'] : '',
     values: List<String>.from(data['Values']),
   );
 }
}
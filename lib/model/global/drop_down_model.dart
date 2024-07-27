class DropDownItemModel {
  String? value;
  String? label;

  DropDownItemModel({
    this.value,
    this.label,
  });

  DropDownItemModel.fromJson(Map<String, dynamic> map) {
    if (map.containsKey('specialization')) {
      value = map['id'];
      label = map['specialization'];
    } else {
      if (map.containsKey('sub_category_id')) {
        value = map['sub_category_id'];
        label = map['sub_category_name'];
      } else if (map.containsKey('category_id')) {
        value = map['category_id'];
        label = map['category_name'];
      } else if (map.containsKey('unit_name')) {
        value = map['id'];
        label = map['unit_name'];
      } else if (map.containsKey('value') &&
          map.containsKey('label') == false) {
        value = map['value'];
        label = map['value'];
      } else {
        value = map['value'].toString().toLowerCase();
        label = map['label'];
      }
    }
  }
}

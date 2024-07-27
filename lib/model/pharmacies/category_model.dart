class CategoryModel {
  String? categoryId;
  String? categoryName;
  List<SubCateogory>? subCateogory;

  CategoryModel({this.categoryId, this.categoryName, this.subCateogory});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['sub_cateogory'] != null) {
      subCateogory = <SubCateogory>[];
      json['sub_cateogory'].forEach((v) {
        subCateogory!.add(SubCateogory.fromJson(v));
      });
    }
  }
}

class SubCateogory {
  String? subCategoryId;
  String? subCategoryName;

  SubCateogory({this.subCategoryId, this.subCategoryName});

  SubCateogory.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
  }
}

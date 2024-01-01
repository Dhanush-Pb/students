class USer {
  int? id;
  String? name;
  String? age;
  String? contact;
  String? Reg;
  String? photo;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['name'] = name!;
    mapping['age'] = age!;
    mapping['contact'] = contact!;
    mapping['Reg'] = Reg!;
    mapping['photo'] = photo!;

    return mapping;
  }
}

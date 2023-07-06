class VideoModel {
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? id;

  VideoModel(
      {
      this.name,
      this.key,
      this.site,
      this.size,
      this.type,
      this.official,
      this.id});

  VideoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['key'] = this.key;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    data['official'] = this.official;
    data['id'] = this.id;
    return data;
  }
}
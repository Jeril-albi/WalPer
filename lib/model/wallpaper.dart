class Wallpapermodel {
  String photographer;
  String img_text;
  int photographer_id;

  SrcModel src;

  Wallpapermodel(
      {this.photographer, this.photographer_id, this.img_text, this.src});

  factory Wallpapermodel.fromMap(Map<String, dynamic> jsonData) {
    return Wallpapermodel(
      src: SrcModel.fromMap(jsonData["src"]),
      img_text: jsonData["alt"],
      photographer_id: jsonData["photographer_id"],
      photographer: jsonData["photographer"],
    );
  }
}

class SrcModel {
  String landscape;
  String small;
  String portrait;

  SrcModel({this.landscape, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData["portrait"],
      landscape: jsonData["landscape"],
      small: jsonData["small"],
    );
  }
}

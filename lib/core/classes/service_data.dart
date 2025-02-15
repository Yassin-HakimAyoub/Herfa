class ServiceData {
  String text, path, image;

  ServiceData({required this.image, required this.path, required this.text});

  get getText => text;
  get getImage => image;
  get getPath => path;
}

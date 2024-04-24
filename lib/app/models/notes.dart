class Notes {

  String title;
  String description;
  final DateTime creationDate = DateTime.now();
  DateTime modificationDate = DateTime.now();
  bool isSelected;

  Notes({
    required this.title,
    required this.description,
    this.isSelected = false,
  });

}
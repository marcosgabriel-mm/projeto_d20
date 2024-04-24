class Notes {
  String title;
  String description;
  DateTime creationDate;
  DateTime modificationDate;
  bool isSelected;

  Notes({
    required this.title,
    required this.description,
    DateTime? creationDate,
    DateTime? modificationDate,
    this.isSelected = false,
  })  : creationDate = creationDate ?? DateTime.now(),
        modificationDate = modificationDate ?? DateTime.now();
}
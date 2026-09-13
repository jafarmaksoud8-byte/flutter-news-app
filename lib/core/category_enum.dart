enum CategoryEnum {
  general(label: 'General'),
  business(label: 'Business'),
  entertainment(label: 'Entertainment'),
  health(label: 'Health'),
  science(label: 'Science'),
  technology(label: 'Technology');

  final String label;
  const CategoryEnum({required this.label});
}

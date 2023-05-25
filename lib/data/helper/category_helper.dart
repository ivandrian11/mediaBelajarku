class CategoryHelper {
  bool isClicked;
  final String id;
  final String title;

  CategoryHelper({
    required this.id,
    required this.title,
    this.isClicked = false,
  });
}

List<CategoryHelper> categories = [
  CategoryHelper(id: "C000", title: 'Semua', isClicked: true),
  CategoryHelper(id: "C001", title: 'Data'),
  CategoryHelper(id: "C002", title: 'Mobile'),
  CategoryHelper(id: "C003", title: 'UX Design'),
];

List<String> activePath = [
  'assets/icon/all_active.svg',
  'assets/icon/data_active.svg',
  'assets/icon/mobile_active.svg',
  'assets/icon/ux_active.svg',
];

List<String> inactivePath = [
  'assets/icon/all_inactive.svg',
  'assets/icon/data_inactive.svg',
  'assets/icon/mobile_inactive.svg',
  'assets/icon/ux_inactive.svg',
];

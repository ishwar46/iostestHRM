class AppLanguage {
  final String name;
  final String languageCode;

  AppLanguage(this.name, this.languageCode);

  static List<AppLanguage> languages() {
    return <AppLanguage>[
      AppLanguage('English', 'en'),
      AppLanguage('Nepali', 'ne'),
    ];
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is AppLanguage && name == other.name;
}

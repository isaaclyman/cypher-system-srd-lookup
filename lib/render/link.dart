abstract class CLink {
  final String label;

  const CLink(this.label);
}

class CSearchQueryLink extends CLink {
  final String query;

  const CSearchQueryLink(super.label, this.query);
}

class CResultLink extends CLink {
  final String resultCategory;
  final String resultName;

  const CResultLink(
    super.label, {
    required this.resultCategory,
    required this.resultName,
  });
}

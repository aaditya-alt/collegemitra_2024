class Services {
  final String name;
  final String position;
  final int averageReview;
  final String totalReview;
  final String profile;

  Services(
      {required this.name,
      required this.position,
      required this.averageReview,
      required this.totalReview,
      required this.profile});
}

List<Services> featuredservices = [
  Services(
      name: 'College Predictor',
      position: 'HSTES Counselling',
      averageReview: 4,
      totalReview: '(195 Reviews)',
      profile: 'assets/images/dashboard_images/hero_section.png'),
  Services(
      name: 'Rank Predictor',
      position: 'JEE Mains',
      averageReview: 4,
      totalReview: '(195 Reviews)',
      profile: 'assets/images/dashboard_images/hero_section.png'),
  Services(
      name: 'College Comparison',
      position: 'UPTU Counselling',
      averageReview: 4,
      totalReview: '(195 Reviews)',
      profile: 'assets/images/dashboard_images/hero_section.png'),
  Services(
      name: 'College List',
      position: 'All Counselling',
      averageReview: 4,
      totalReview: '(195 Reviews)',
      profile: 'assets/images/dashboard_images/hero_section.png'),
];

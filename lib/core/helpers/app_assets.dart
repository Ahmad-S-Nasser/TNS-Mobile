import 'extension.dart';

class AssetPaths {
  static String _getPath(String folder, String file, String extension) {
    return 'assets/$folder/$file$extension';
  }

  static String svgIcon(String icon) => _getPath('icons', icon, '.svg');

  static String pngIcon(String icon) => _getPath('icons', icon, '.png');

  static String pngImage(String image) => _getPath('images', image, '.png');

  static String jsonFile(String file) => _getPath('animations', file, '.json');
}

class AppIcons {
  static String activity = 'activity'.svgIcon;
  static String alert = 'alert'.svgIcon;
  static String back = 'back'.svgIcon;
  static String book = 'book'.svgIcon;
  static String bookmark = 'bookmark'.svgIcon;
  static String brain = 'brain'.svgIcon;
  static String calendar = 'calendar'.svgIcon;
  static String aiBot = 'ai_bot'.svgIcon;
  static String clock = 'clock'.svgIcon;
  static String community = 'community'.svgIcon;
  static String download = 'download'.svgIcon;
  static String eye = 'eye'.svgIcon;
  static String home = 'home'.svgIcon;
  static String mapPin = 'map-pin'.svgIcon;
  static String messageCircle = 'message-circle'.svgIcon;
  static String phone = 'phone'.svgIcon;
  static String play = 'play'.svgIcon;
  static String printer = 'printer'.svgIcon;
  static String settings = 'settings'.svgIcon;
  static String share2 = 'share-2'.svgIcon;
  static String shield = 'shield'.svgIcon;
  static String star = 'star'.svgIcon;
  static String syringe = 'syringe'.svgIcon;
  static String target = 'target'.svgIcon;
  static String users = 'users'.svgIcon;
}

class AppImages {
  static String logo = 'Logo'.pngImage;
  static String hayahLogo = 'hayah'.pngImage;
  static String growth = '7e0cfe3b1d5677cdf53cc49788c2d44561fd4804'.pngImage;
  static String behavioral =
      'c6e60dec0fe812c39b4df806c990ccfd84ee5443'.pngImage;
  static String psychological =
      'ca1dd28636e5a3b812dc3a393677de9903d91b29'.pngImage;
  static String nutrition = '5b1eabc65ffd832a124827ac71f4795a6b37ea43'.pngImage;
  static String sexEducation =
      'ec6b9f0e67fcf05f913817e9c762a1e772bb7c42'.pngImage;
  static String hospitals = '1d7697dffee4d5497be52ab0fa270092bba71e19'.pngImage;
  static String healthUnits =
      'c9b1b5ad7e2654a6238a1ea2113ff218673cb206'.pngImage;
  static String emergency = '5de9f3734fc2e7c554d662579f2a91b3ee34bc91'.pngImage;
  static String onboardingWelcome = 'onboarding_welcome'.pngImage;
  static String onboardingLearning = 'onboarding_learning'.pngImage;
}

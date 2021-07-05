import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:flutter/services.dart' show rootBundle;
import './size_controller.dart';
import './constant.dart';
import './models/district.dart';

class Parser {
  static Parser? _instance;

  static Parser get instance {
    _instance ??= Parser._init();
    return _instance!;
  }

  final sizeController = SizeController.instance;

  Parser._init();

  Future<List<District>> svgToDistrictList(String country) async {

    final svgCountry = await rootBundle.loadString(
        '${Constants.ASSETS_PATH}/$country'
    );

    List<District> districtList = [];

    final regExp = RegExp(Constants.MAP_REGEXP,
        multiLine: true, caseSensitive: false, dotAll: false);

    regExp.allMatches(svgCountry).forEach((districtData) {
      final district = District(
          id: districtData.group(1)!,
          title: districtData.group(2)!,
          path: parseSvgPath(districtData.group(3)!));

      sizeController.addBounds(district.path.getBounds());
      districtList.add(district);
    });
    return districtList;
  }
}
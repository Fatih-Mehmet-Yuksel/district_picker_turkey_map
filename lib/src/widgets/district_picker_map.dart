import 'package:flutter/material.dart';
import './district_painter.dart';
import '../models/district.dart';
import '../parser.dart';
import '../size_controller.dart';

class DistrictPickerMap extends StatefulWidget {
  final double? width;
  final double? height;
  final String map;
  final Function(District? district) onChanged;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;
  final bool? actAsToggle;

  DistrictPickerMap(
      {Key? key,
        required this.map,
        required this.onChanged,
        this.width,
        this.height,
        this.strokeColor,
        this.selectedColor,
        this.dotColor,
        this.actAsToggle}) : super(key: key);

  @override
  DistrictPickerMapState createState() => DistrictPickerMapState();
}

class DistrictPickerMapState extends State<DistrictPickerMap> {
  final List<District> _districtList = [];
  District? selectedDistrict;

  final _sizeController = SizeController.instance;
  Size? mapSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _loadDistrictList();
    });
  }

  _loadDistrictList() async {
    final list = await Parser.instance.svgToDistrictList(widget.map);
    _districtList.clear();
    setState(() {
      _districtList.addAll(list);
      mapSize = _sizeController.mapSize;
    });
  }

  void clearSelect() {
    setState(() {
      selectedDistrict = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var district in _districtList) _buildStackItem(district),
      ],
    );
  }

  Widget _buildStackItem(District district) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => (widget.actAsToggle ?? false)
          ? _toggleButton(district)
          : _useButton(district),
      child: CustomPaint(
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? double.infinity,
          constraints: BoxConstraints(
              maxWidth: mapSize?.width ?? 0, maxHeight: mapSize?.height ?? 0),
          alignment: Alignment.center,
        ),
        isComplex: true,
        foregroundPainter: DistrictPainter(
            district: district,
            selectedDistrict: selectedDistrict,
            dotColor: widget.dotColor,
            selectedColor: widget.selectedColor,
            strokeColor: widget.strokeColor),
      ),
    );
  }

  void _toggleButton(District district) {
    setState(() {
      if (selectedDistrict == district)
        selectedDistrict = null;
      else {
        selectedDistrict = district;
      }
      widget.onChanged.call(selectedDistrict);
    });
  }

  void _useButton(District district) {
    setState(() {
      selectedDistrict = district;
      widget.onChanged.call(selectedDistrict);
    });
  }
}
# district_picker_turkey_map

A flutter package for select a province of Turkish cities from svg map. 
similar to City Picker From Map created by [Ahmet ÇELİK](https://github.com/ahm3tcelik/city_picker_from_map)

Supported cities
-Ankara
-Istanbul
-Konya

This is a first release. Other cities coming soon.

## Getting Started

In the `pubspec.yaml` of your **Flutter** project, add the following dependency:

```yaml
dependencies:
  ...
  district_picker_turkey_map: any
```

In your library file add the following import:

```dart
import 'package:district_picker_turkey_map/district_picker_turkey_map.dart';
```

## Usage

```dart
DistrictPickerMap(
	width: double.infinity,
	height: double.infinity,
	map: Maps.ANKARA,
	onChanged: (district) {
	  setState(() {
		selectedDistrict = district;
	  });
	},
	actAsToggle: true,
	dotColor: Colors.white,
	selectedColor: Colors.lightBlueAccent,
	strokeColor: Colors.white24,
)
```
## Props
| props                   | types           | description                                                                                                     |
| :---------------------- | :-------------: | :---------------------------------------------------------------------------------------------------------------: |
| key        | `Key?`        |  |
| map       | `String`     | Name of the map you want to show. Use as Maps.<MAP_NAME> All maps are in the [maps.dart](https://github.com/Fatih-Mehmet-Yuksel/district_picker_turkey_map/blob/master/lib/src/maps.dart)  |
| width           | `double?`     | Map width. Default value is double.infinity |
| height       | `double?`     | Map height. Default value is double.infinity |
| dotColor | `Color?`         | Color of the dot in the center of the district  |
| strokeColor       | `Color?`     | Color of the district borders |
| selectedColor       | `Color?`     | Color of the selected district |
| actAsToggle | `boolean?`         | District selecting act as like toggle button |
| onChanged       | `Function(District? district)`     | Returns new district value when it changed |
## Contributors

Much thanks to [Ahmet ÇELİK](https://github.com/ahm3tcelik/)


Author
------

* [Fatih Mehmet YÜKSEL](https://github.com/Fatih-Mehmet-Yuksel/)
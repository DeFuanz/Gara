import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class WebScraperApi {
  Future<Map<String, List<String>>> getCarMakeAndModels() async {
    var url = Uri.parse('https://www.carmodelslist.com/car-manufacturers/');

    Map<String, List<String>> carBrands = {};

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var brandElements = document.querySelectorAll(
            'a[title*="Car Models List"]:not([title*="List on"])');

        for (var brandElement in brandElements) {
          var title = brandElement.attributes['title'];
          var carName = title?.replaceAll(' Car Models List', '');
          var link = brandElement.attributes['href'];
          if (carBrands.containsKey(carName)) {
            continue;
          }

          carBrands[carName!] = [];

          var url = Uri.parse(link!);
          var response = await http.get(url);
          if (response.statusCode == 200) {
            var document = parser.parse(response.body);

            var listElements = document.querySelectorAll('li');
            for (var listElement in listElements) {
              if (listElement.text.contains(carName)) {
                if (!carBrands.containsKey(carName) ||
                    !carBrands[carName]!.contains(listElement.text)) {
                  carBrands
                      .putIfAbsent(carName, () => [])
                      .add(listElement.text);
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    return carBrands;
  }
}

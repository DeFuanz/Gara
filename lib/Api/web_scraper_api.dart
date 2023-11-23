import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class WebScraperApi {
  //Urls for scraping vehicle data
  var carBrandsUrl =
      Uri.parse('https://en.wikipedia.org/wiki/List_of_car_brands');

  //Grab car brands (make) for each country
  Future<Map<String, List<String>>> getCarBrands() async {
    //Car brands country / car brands make list per country
    Map<String, List<String>> carBrands = {};

    try {
      var response = await http.get(carBrandsUrl);

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        //Select all h3 tags from the page. (active brands is currently always h3)
        var activeBrandElements = document.querySelectorAll('h3');

        //If query successful, grab all the h3 text
        if (activeBrandElements.isNotEmpty) {
          for (var activeBrandElement in activeBrandElements) {
            var activeBrandText = activeBrandElement.text;

            //Check if h3 contains 'Active brands' label then grab all the h2's (country tags are h2's)
            if (activeBrandText.contains('Active brands')) {
              var h2Element = activeBrandElement.previousElementSibling;

              //iterate until found h2 tag above active brands label
              while (h2Element != null && h2Element.localName != 'h2') {
                h2Element = h2Element.previousElementSibling;
              }

              //Check if found h2 and query for spans (all country text are within spans)
              if (h2Element != null) {
                var spanElement = h2Element.querySelector('span');

                //grab country name and add to Map as key
                if (spanElement != null) {
                  carBrands[spanElement.text] = [];
                  print(spanElement.text);

                  var ulElement = activeBrandElement.nextElementSibling;

                  //due to layout, some lists are in divs while others are not. filter here
                  while (ulElement != null &&
                      ulElement.localName != 'div' &&
                      ulElement.localName != 'ul') {
                    ulElement = ulElement.nextElementSibling;
                  }

                  //Grab all list elements from below the active brands tag for the searched country
                  if (ulElement != null) {
                    var liElements = ulElement.querySelectorAll('li');

                    for (var liElement in liElements) {
                      var linkElement = liElement.querySelector('a');

                      if (linkElement != null) {
                        var text = linkElement.text;
                        carBrands[spanElement.text]!.add(text);
                        print('Make: $text');
                      }
                    }
                  }
                }
              }
            }
          }
        } else {
          print('Elements not found');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return carBrands;
  }
}

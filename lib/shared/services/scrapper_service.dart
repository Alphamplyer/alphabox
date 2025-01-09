
import 'package:universal_html/controller.dart';
import 'package:universal_html/html.dart';

class ScrapperService {  
  Document? document;
  
  ScrapperService();

  Future<void> load(String url) async {
    print("Loading url: $url");
    final controller = WindowController();
    await controller.openHttp(
      method: 'GET',
      uri: Uri.parse(url),
      // Uncomment below code to see the response details
      // onResponse: (HttpClientResponse response) {
      //   print('Status code: ${response.statusCode}');
      //   print('reasonPhrase: ${response.reasonPhrase}');
      //   print("content length: ${response.contentLength}");
      // },
    );
    document = controller.window.document;
    
    // Uncomment below code to see the html content
    // if (document == null) {
    //   throw Exception('Document is null. Did you forget to call load() method?');
    // }
    // Node htmlNode = document!.getElementsByTagName("html").first;
    // print("htmlNode.text: ${htmlNode.text}");
    // print("htmlNode.nodeValue: ${htmlNode.nodeValue}");
  }

  List<Element> querySelectorAll(String selector) {
    if (document == null) {
      throw Exception('Document is null. Did you forget to call load() method?');
    }
    return document!.querySelectorAll(selector);
  }

  Element? querySelector(String selector) {
    if (document == null) {
      throw Exception('Document is null, Did you forget to call load() method?');
    }
    return document!.querySelector(selector);
  }
}
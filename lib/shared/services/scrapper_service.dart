
import 'package:universal_html/controller.dart';
import 'package:universal_html/html.dart';

class ScrapperService {  
  Document? document;
  
  ScrapperService();

  Future<void> load(String url) async {
    final controller = WindowController();
    await controller.openHttp(
      method: 'GET',
      uri: Uri.parse(url),
    );
    document = controller.window.document;
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
import 'package:html_unescape/html_unescape.dart';

class HtmlUtil {
    // Elimina las secuencias de escape y convierte el texto HTML en texto plano
  static String decodeHtml(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }

  // Utiliza esta función para procesar el texto en tu aplicación
  static String processText(String text) {
    return decodeHtml(text);
  }
}
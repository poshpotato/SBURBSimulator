import "dart:html";
import "dart:typed_data";

import "package:CommonLib/Compression.dart";
import "package:CommonLib/Colours.dart";
import "package:CommonLib/Random.dart";
import "package:ImageLib/Encoding.dart";
import "package:LoaderLib/Loader.dart";

PngController controller = new PngController();

main() async {
  querySelector(".decodeUrl").onClick.listen((_) async => mapToTable(await controller.decodePngUrl((querySelector(".imageUrlInput") as TextInputElement).value)));
  querySelector(".decodeFile").onClick.listen(((_) => getFileFromInput()));
}

getFileFromInput() async{
  for(int i = 0; i<(querySelector(".imageFileInput") as FileUploadInputElement).files.length; i++) {
    FileReader reader = new FileReader();
    reader.readAsArrayBuffer((querySelector(".imageFileInput") as FileUploadInputElement).files.elementAt(i));
    reader.onLoadEnd.listen((_) async => mapToTable(await controller.decodePngFile(reader.result as Uint8List)));
  }

}

mapToTable(Map decoded){
  for(int i = 0; i<decoded.keys.length; i++) {
    querySelector("#decodeTable").appendHtml("<th>" + decoded.keys.elementAt(i) + "</th><th>" + decoded.values.elementAt(i) + "</th>");
  }
}
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRUtil {
  static final _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.japanese,
  );

  static Future<List<String>> imageToTextList(InputImage inputImage) async {
    List<String> textList = [];
    RecognizedText recognizedText;
    try {
      recognizedText = await _textRecognizer.processImage(inputImage);
    } catch (e) {
      rethrow;
    }
    for (TextBlock block in recognizedText.blocks) {
      textList.add(block.text);
    }
    return textList;
  }
}

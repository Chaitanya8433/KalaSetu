import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProductService {
  static Future<String> identifyProduct({
    required File image,
    required String apiKey,
  }) async {
    final model = GenerativeModel(
    model: 'gemini-3.6-flash',
      apiKey: apiKey,
    );

    final imageBytes = await image.readAsBytes();

    final prompt = '''
Look at this product image and identify the main product.

Return ONLY the product name.
Do not give a description.
Do not mention color, material, brand, or background.
If you are unsure, give the most likely general product name.

Example:
Eyeglasses Case
Handmade Pot
Wooden Bowl
Cloth Bag
Wall Hanging
''';

    final content = Content.multi([
      TextPart(prompt),
      DataPart('image/png', imageBytes),
    ]);

    final response = await model.generateContent([content]);

    final result = response.text?.trim();

    if (result == null || result.isEmpty) {
      throw Exception('Could not identify the product.');
    }

    return result;
  }
}
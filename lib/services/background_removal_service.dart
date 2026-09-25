import 'dart:io';
import 'package:http/http.dart' as http;

class BackgroundRemovalService {
  static Future<File> removeBackground({
    required File image,
    required String apiKey,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
    );

    request.headers['X-Api-Key'] = apiKey;

    request.fields['size'] = 'auto';

    request.files.add(
      await http.MultipartFile.fromPath(
        'image_file',
        image.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      final error = await response.stream.bytesToString();

      throw Exception(
        'Background removal failed (${response.statusCode}): $error',
      );
    }

    final bytes = await response.stream.toBytes();

    final outputFile = File(
      '${image.parent.path}/kalasetu_no_background.png',
    );

    await outputFile.writeAsBytes(bytes);

    return outputFile;
  }
}
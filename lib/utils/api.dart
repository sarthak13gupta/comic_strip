import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future<Image> generateImage(String userInput, int id) async {
  try {
    final response = await _callApi({"inputs": userInput});

    return Image.memory(response);
  } catch (e) {
    // print("Error: $e");
    throw Exception(e);
    // Handle error as needed
  }
}

Future<Uint8List> _callApi(Map<String, String> data) async {
  Dio dio = Dio();
  String apiUrl =
      "https://xdwvg9no7pefghrn.us-east-1.aws.endpoints.huggingface.cloud";

  try {
    // Convert the Map to a JSON-formatted string
    String jsonData = json.encode(data);

    // Make a POST request using Dio
    Response<List<int>> response = await dio.post(
      apiUrl,
      options: Options(
        responseType:
            ResponseType.bytes, // Specify that you expect bytes in the response
        headers: {
          "Accept": "image/png",
          "Authorization":
              "Bearer VknySbLLTUjbxXAXCjyfaFIPwUTCeRXbFSOjwRiCxsxFyhbnGjSFalPKrpvvDAaPVzWEevPljilLVDBiTzfIbWFdxOkYJxnOPoHhkkVGzAknaOulWggusSFewzpqsNWM",
          "Content-Type": "application/json",
        },
      ),
      data: jsonData,
    );

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data!);
    } else {
      throw Exception('Failed to load image');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Failed to load image');
  }
}

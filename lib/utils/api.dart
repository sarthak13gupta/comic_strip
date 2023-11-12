import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:comic_strip/utils/app_exceptions.dart';
import 'package:comic_strip/widgets/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Future<Image> generateImage(
    String userInput, int id, BuildContext context) async {
  try {
    final response = await _callApi({"inputs": userInput}, context);

    return Image.memory(response);
  } catch (e) {
    throw Exception(e);
  }
}

Future<Uint8List> _callApi(
    Map<String, String> data, BuildContext context) async {
  Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 60)));
  String apiUrl =
      "https://xdwvg9no7pefghrn.us-east-1.aws.endpoints.huggingface.cloud";
  var uri = Uri.parse(apiUrl);

  try {
    // Convert the Map to a JSON-formatted string
    String jsonData = json.encode(data);

    // Make a POST request using Dio
    print("loading");
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
    print("loaded");

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data!);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: apiUrl),
        response: response,
      );
    }
  } on DioException catch (error) {
    ApiException exception = ApiException();
    List<String> message = exception.getExceptionMessage(error);
    // add bloc function here
    await showErrorDialog(context: context, message: message);
    throw Exception(error);
  } catch (e) {
    showErrorDialog(context: context, message: ["Error", e.toString()]);
    throw Exception(e);
  }
}

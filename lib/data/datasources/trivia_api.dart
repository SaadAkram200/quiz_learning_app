import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/question/question_model.dart';

class TriviaApi {
  final Dio dio;
  Map<String, List<QuestionModel>>? _cachedMockQuestions;

  TriviaApi(this.dio);

  Future<List<QuestionModel>> fetchQuestions({
    required int categoryId,
    int amount = 10,
    String? difficulty,
    String type = 'multiple',
  }) async {
    debugPrint('[TriviaAPI] Platform: ${kIsWeb ? "WEB" : "MOBILE"}');
    debugPrint('[TriviaAPI] Fetching questions for category: $categoryId, amount: $amount');
    
    try {
      final queryParams = <String, dynamic>{
        'amount': amount,
        'category': categoryId,
        'type': type,
      };

      if (difficulty != null) {
        queryParams['difficulty'] = difficulty;
      }

      final url = '/api.php?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
      debugPrint('[TriviaAPI] Request URL: ${dio.options.baseUrl}$url');

      final response = await dio.get('/api.php', queryParameters: queryParams);

      debugPrint('[TriviaAPI] Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;

        final responseCode = data['response_code'] as int;
        debugPrint('[TriviaAPI] API response_code: $responseCode');

        if (responseCode != 0) {
          throw TriviaApiException(
            getErrorMessage(responseCode),
            responseCode,
          );
        }

        final results = data['results'] as List<dynamic>;
        debugPrint('[TriviaAPI] SUCCESS! Fetched ${results.length} questions from LIVE API');
        return results
            .map((json) => QuestionModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw TriviaApiException(
          'Failed to fetch questions: ${response.statusCode}',
          response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      debugPrint('[TriviaAPI] DioException: ${e.message}');
      debugPrint('[TriviaAPI] Error type: ${e.type}');
      if (kIsWeb) {
        debugPrint('[TriviaAPI] Web platform detected - falling back to MOCK DATA');
        return getMockQuestions(categoryId, amount);
      }
      throw TriviaApiException(
        'Network error: ${e.message}',
        e.response?.statusCode ?? 500,
      );
    } catch (e) {
      debugPrint('[TriviaAPI] General Exception: $e');
      if (kIsWeb) {
        debugPrint('[TriviaAPI] Web platform detected - falling back to MOCK DATA');
        return getMockQuestions(categoryId, amount);
      }
      rethrow;
    }
  }

  String getErrorMessage(int responseCode) {
    switch (responseCode) {
      case 1:
        return 'No questions available for this category. Please try another.';
      case 2:
        return 'Invalid parameters provided.';
      case 3:
        return 'Session token not found.';
      case 4:
        return 'No more questions available. Please try later.';
      default:
        return 'Unknown error occurred.';
    }
  }

  Future<void> loadMockQuestions() async {
    if (_cachedMockQuestions != null) return;

    try {
      final jsonString = await rootBundle.loadString('assets/data/mock_questions.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      
      _cachedMockQuestions = {};
      jsonData.forEach((categoryId, questions) {
        final questionList = (questions as List<dynamic>)
            .map((q) => QuestionModel.fromJson(q as Map<String, dynamic>))
            .toList();
        _cachedMockQuestions![categoryId] = questionList;
      });
      
      debugPrint('[TriviaAPI] Loaded mock questions from JSON for ${_cachedMockQuestions!.length} categories');
    } catch (e) {
      debugPrint('[TriviaAPI] Failed to load mock questions: $e');
      _cachedMockQuestions = {};
    }
  }

  Future<List<QuestionModel>> getMockQuestions(int categoryId, int amount) async {
    debugPrint('[TriviaAPI] Using MOCK DATA for category: $categoryId');
    
    await loadMockQuestions();
    
    final categoryQuestions = _cachedMockQuestions?[categoryId.toString()];
    if (categoryQuestions != null && categoryQuestions.isNotEmpty) {
      final questions = categoryQuestions.take(amount).toList();
      debugPrint('[TriviaAPI] Returning ${questions.length} mock questions for category $categoryId');
      return questions;
    }
    
    final fallbackQuestions = _cachedMockQuestions?['9'] ?? [];
    final questions = fallbackQuestions.take(amount).toList();
    debugPrint('[TriviaAPI] Category $categoryId not found, using fallback. Returning ${questions.length} questions');
    return questions;
  }
}

class TriviaApiException implements Exception {
  final String message;
  final int code;

  TriviaApiException(this.message, this.code);

  @override
  String toString() => 'TriviaApiException: $message (code: $code)';
}

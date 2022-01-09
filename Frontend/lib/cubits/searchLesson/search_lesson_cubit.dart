import 'package:bikolayders/models/searchLesson/search_lesson_request_model.dart';
import 'package:bikolayders/models/searchLesson/search_lesson_response_model.dart';
import 'package:bikolayders/services/search_lesson_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchLessonCubit extends Cubit<SearchLessonState> {
  final SearchLessonService service;
  SearchLessonCubit(this.service) : super(SearchLessonInitial());

  List<SearchLessonResponseData> lessonDatas = [];
  String? lastSearched;

  void searchLesson(String search) async {
    if (lastSearched == search) return;
    lastSearched = search;
    emit(SearchLessonLoading());
    lessonDatas.clear();
    final response = await service
        .searchLesson(SearchLessonRequestModel(search: search))
        .then((value) => emit(SearchLessonComplete(value?.data ?? [])));
  }
}

abstract class SearchLessonState {}

class SearchLessonInitial extends SearchLessonState {}

class SearchLessonLoading extends SearchLessonState {}

class SearchLessonComplete extends SearchLessonState {
  final List<SearchLessonResponseData?> data;

  SearchLessonComplete(this.data);
}

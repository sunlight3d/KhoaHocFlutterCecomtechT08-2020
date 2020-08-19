import 'package:equatable/equatable.dart';

class Response extends Equatable {
  final Object result;
  final String error;
  Response({this.result, this.error});
  @override
  List<Object> get props => [result, error];
}
import '../../sale_assist_tiles/model/shorts_model/shorts_model.dart';

class SaleAssistFullScreenEvent {}

class SaleAssistFullScreenChangePageEvent extends SaleAssistFullScreenEvent {
  final int pageIndex;

  SaleAssistFullScreenChangePageEvent({
    required this.pageIndex,
  });
}

class SaleAssistFullScreenInitEvent extends SaleAssistFullScreenEvent {
  final ShortsModel? shortsModel;
  final int index;
  SaleAssistFullScreenInitEvent(
      {required this.shortsModel, required this.index});
}

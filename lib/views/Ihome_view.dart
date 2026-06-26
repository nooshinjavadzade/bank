import '../models/card_model.dart';
abstract class IHomeView {
  void onCardsLoaded(List<BankCardModel> cards);
  void onError(String message);
}

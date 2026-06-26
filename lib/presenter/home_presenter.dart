import '../views/Ihome_view.dart';
import '../models/card_model.dart'; 

class HomePresenter {
  final IHomeView _view;
  
  HomePresenter(this._view);

  void loadUserCards() async {
    // شبیه‌سازی تاخیر شبکه برای واقعی‌تر شدن لودینگ در مینی‌لب
    await Future.delayed(const Duration(milliseconds: 800));

    final mockCards = [
      BankCardModel(
        bankName: "بانک ملی", 
        cardNumber: "6037-9918-2736-4552", // شماره کارت دقیق داخل فایل HTML شما
        cvv2: "482", 
        expireDate: "05/27", 
        holderName: "سارا احمدی",
        backgroundColorHex: 0xFFE0F2FE, // همان رنگ آبی ملایم کارت اصلی در HTML (#E0F2FE)
      ),
      BankCardModel(
        bankName: "بانک ملت", 
        cardNumber: "6104-3377-1122-5678", 
        cvv2: "951", 
        expireDate: "08/29", 
        holderName: "سارا احمدی",
        backgroundColorHex: 0xFFFADADD, // رنگ صورتی تم تلویند برای تنوع کارت دوم
      ),
    ];
    
    _view.onCardsLoaded(mockCards);
  }
}
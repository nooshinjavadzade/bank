class BankCardModel {
  final String bankName;
  final String cardNumber;
  final String cvv2;
  final String expireDate;
  final String holderName;
  final int backgroundColorHex;

  BankCardModel({
    required this.bankName,
    required this.cardNumber,
    required this.cvv2,
    required this.expireDate,
    required this.holderName,
    required this.backgroundColorHex,
  });
}
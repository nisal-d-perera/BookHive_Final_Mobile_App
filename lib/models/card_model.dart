class Cards{
  final int userId;
  final String cardType;
  final String cardNumber;
  final String cardHolder;
  final String expirationDate;
  final int cvv;

  Cards({
    required this.userId,
    required this.cardType,
    required this.cardNumber,
    required this.cardHolder,
    required this.expirationDate,
    required this.cvv,
  });
}
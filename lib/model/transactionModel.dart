// ignore_for_file: file_names

class TransactionModel {
  int? id;
  String categoryType;
  String date;
  String amount;
  String description;
  String transactionType;
  TransactionModel({
    this.id,
    required this.categoryType,
    required this.date,
    required this.amount,
    required this.description,
    required this.transactionType,
  });
  factory TransactionModel.fromdatabaseJson(Map<String, dynamic> data) =>
      TransactionModel(
          id: data['id'],
          categoryType: data['transactioncategorytype'],
          date: data['date'],
          amount: data['amount'],
          description: data['description'],
          transactionType: data['transactionType']);
  Map<String, dynamic> todatabaseJson() => {
        'id': id,
        'transactioncategorytype': categoryType,
        'date': date,
        'amount': amount,
        'description': description,
        'transactionType': transactionType,
      };
}

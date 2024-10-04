class CardModel {
  final int id;
  final String frontDesign;
  bool isFaceUp;

  CardModel(
      {required this.id, required this.frontDesign, this.isFaceUp = false});
}

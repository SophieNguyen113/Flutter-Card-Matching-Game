import 'package:flutter/foundation.dart';
import 'card_model.dart';

class GameNotifier with ChangeNotifier {
  List<CardModel> cards = [];
  CardModel? previousCard;

  void initializeGame() {
    List<String> designs = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    cards = [];
    for (var design in designs) {
      cards.add(CardModel(id: cards.length, frontDesign: design));
      cards.add(CardModel(id: cards.length, frontDesign: design));
    }
    cards.shuffle();
    notifyListeners();
  }

  void onCardTapped(CardModel card) {
    if (!card.isFaceUp && previousCard != card) {
      card.isFaceUp = true;
      notifyListeners();
      if (previousCard != null) {
        if (card.frontDesign == previousCard!.frontDesign) {
          previousCard = null;
        } else {
          Future.delayed(Duration(seconds: 1), () {
            card.isFaceUp = false;
            previousCard!.isFaceUp = false;
            previousCard = null;
            notifyListeners();
          });
        }
      } else {
        previousCard = card;
      }
    }
  }

  bool checkWinCondition() {
    return cards.every((card) => card.isFaceUp);
  }

  void resetGame() {
    initializeGame();
    previousCard = null;
    notifyListeners();
  }
}

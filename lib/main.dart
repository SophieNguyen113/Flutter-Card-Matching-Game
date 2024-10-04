import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_notifier.dart';
import 'flip_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameNotifier()..initializeGame(),
      child: MaterialApp(
        title: 'Sophie Card Matching Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CardMatchingGame(),
      ),
    );
  }
}

class CardMatchingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sophie Card Matching Game')),
      body: Consumer<GameNotifier>(
        builder: (context, game, _) {
          if (game.checkWinCondition()) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Congrats! You Win!', style: TextStyle(fontSize: 26)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: game.resetGame,
                    child: Text('Play Again'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: game.cards.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () => game.onCardTapped(game.cards[index]),
                  child: FlipCard(
                    isFaceUp: game.cards[index].isFaceUp,
                    frontDesign: game.cards[index].frontDesign,
                    onTap: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

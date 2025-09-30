// Blackjack in Processing

// Besturing met muisklikken op knoppen "Hit" en "Stand"
 
ArrayList<Card> deck;

ArrayList<Card> playerHand;

ArrayList<Card> dealerHand;
 
boolean gameOver = false;

String message = "";
 
void setup() {

  size(600, 400);

  startGame();

}
 
void draw() {

  background(0, 120, 0);
 
  // Kaarten tonen

  fill(255);

  textSize(20);

  text("Dealer's Hand:", 50, 50);

  for (int i = 0; i < dealerHand.size(); i++) {

    dealerHand.get(i).show(50 + i*60, 70);

  }
 
  text("Player's Hand:", 50, 250);

  for (int i = 0; i < playerHand.size(); i++) {

    playerHand.get(i).show(50 + i*60, 270);

  }
 
  // Knoppen tekenen

  if (!gameOver) {

    drawButton("Hit", 400, 280);

    drawButton("Stand", 500, 280);

  }
 
  // Bericht tonen

  if (gameOver) {

    fill(255, 255, 0);

    textSize(24);

    text(message, width/2 - textWidth(message)/2, height/2);

    drawButton("Restart", 450, 330);

  }

}
 
void startGame() {

  deck = createDeck();

  shuffle(deck);
 
  playerHand = new ArrayList<Card>();

  dealerHand = new ArrayList<Card>();
 
  // Kaarten uitdelen

  playerHand.add(deck.remove(0));

  dealerHand.add(deck.remove(0));

  playerHand.add(deck.remove(0));

  dealerHand.add(deck.remove(0));
 
  gameOver = false;

  message = "";

}
 
void mousePressed() {

  if (!gameOver) {

    if (overButton(400, 280, 80, 40)) {

      // HIT

      playerHand.add(deck.remove(0));

      if (handValue(playerHand) > 21) {

        gameOver = true;

        message = "You BUST! Dealer wins!";

      }

    }

    if (overButton(500, 280, 80, 40)) {

      // STAND -> dealer speelt

      dealerTurn();

      checkWinner();

    }

  } else {

    if (overButton(450, 330, 100, 40)) {

      startGame();

    }

  }

}
 
void dealerTurn() {

  while (handValue(dealerHand) < 17) {

    dealerHand.add(deck.remove(0));

  }

}
 
void checkWinner() {

  int p = handValue(playerHand);

  int d = handValue(dealerHand);

  if (d > 21) {

    message = "Fuck you pussy";

  } else if (p > d) {

    message = "You win!";

  } else if (p < d) {

    message = "Dealer wins!";

  } else {

    message = "Push (Draw)!";

  }

  gameOver = true;

}
 
// ------------ Hulpfuncties ------------
 
ArrayList<Card> createDeck() {

  ArrayList<Card> d = new ArrayList<Card>();

  String[] suits = {"♠", "♥", "♦", "♣"};

  String[] ranks = {"A","2","3","4","5","6","7","8","9","10","J","Q","K"};

  for (String s : suits) {

    for (int i=0; i<ranks.length; i++) {

      d.add(new Card(ranks[i], s));

    }

  }

  return d;

}
 
void shuffle(ArrayList<Card> d) {

  for (int i = d.size()-1; i > 0; i--) {

    int j = int(random(i+1));

    Card temp = d.get(i);

    d.set(i, d.get(j));

    d.set(j, temp);

  }

}
 
int handValue(ArrayList<Card> hand) {

  int value = 0;

  int aces = 0;

  for (Card c : hand) {

    int v = c.getValue();

    if (c.rank.equals("A")) aces++;

    value += v;

  }

  while (value > 21 && aces > 0) {

    value -= 10;

    aces--;

  }

  return value;

}
 
void drawButton(String label, int x, int y) {

  fill(50, 50, 200);

  rect(x, y, 80, 40, 8);

  fill(255);

  textSize(16);

  text(label, x + 40 - textWidth(label)/2, y+25);

}
 
boolean overButton(int x, int y, int w, int h) {

  return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;

}
 
// ------------ Kaart Klasse ------------
 
class Card {

  String rank;

  String suit;
 
  Card(String r, String s) {

    rank = r;

    suit = s;

  }
 
  int getValue() {

    if (rank.equals("A")) return 11;

    else if (rank.equals("K") || rank.equals("Q") || rank.equals("J")) return 10;

    else return int(rank);

  }
 
  void show(int x, int y) {

    fill(255);

    rect(x, y, 50, 70, 5);

    fill(suit.equals("♥") || suit.equals("♦") ? color(0,255,255) : color(0));

    textSize(16);

    text(rank+suit, x+5, y+20);

  }

}
 

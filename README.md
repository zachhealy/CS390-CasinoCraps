# CS390-CasinoCraps

In the Fall 2023 semester at SEMO, I took CS390 (Programming Languages), we took a journey though history in order to look into some of the older languages that made big advancements in computer science. With each language, we had to make a craps simulator in order to help define our skills more!

## Languages Represented

- Fortran
- COBOL
- F#

## Requirments for each program

1. Initial Setup:

   The game should begin with an initial player balance of $500.00.
   Minimum bet: $10.00. Maximum bet: $200.00. Players attempting to place bets outside these limits should receive an error message.
   Before the comeout roll, present the user with a menu to place their bets. The options should be:
   Pass Line Bet
   Don’t Pass Line Bet
   Roll the Dice

2. The Comeout Roll Phase:

   After placing a bet, the user can select to roll the dice. The program should simulate rolling two six-sided dice and summing their outcomes.
   If the sum is 7 or 11 on the comeout roll, the Pass Line bet wins.
   If the sum is 2, 3, or 12 on the comeout roll, the Don’t Pass Line bet wins (12 is often a tie in real casinos, but for simplicity, treat it as a win for Don't Pass here).
   If the sum is 4, 5, 6, 8, 9, or 10, this becomes the "point," and the game moves to the point phase.
   All Come and Don't Come bets are cleared on a comeout roll of 7.

3. The Point Phase:

   Display the "puck" on the board by printing "ON" next to the current point.
   During the point rolls, present the user with a menu to place additional bets. The options should be:
   Come Line Bet
   Don’t Come Line Bet
   Roll the Dice
   If the shooter rolls the current point before rolling a 7, Pass Line bet wins.
   If a 7 is rolled before the point, the Don’t Pass Line bet wins.
   For the Come and Don’t Come bets, if the next roll after placing the bet is a 7 or 11, the Come bet wins. If it's 2, 3, or 12, the Don’t Come bet wins.
   If the roll is any other number (4, 5, 6, 8, 9, or 10), that number becomes the point for that specific Come or Don't Come bet and the bet "travels" to that number.
   If that specific point is rolled again before a 7, the Come bet on that point wins. If a 7 is rolled before that specific point, the Don’t Come bet on that point wins.

4. Payouts:

   Winning Pass Line and Come bets pay 1:1 odds.
   Winning Don't Pass and Don't Come bets pay 1:1 odds.

5. Game Messages and Display:

   After each roll, the game should print an appropriate message indicating the outcome of the roll and the status of the game.
   Display the betting board after each roll, showing the status of all line bets and point bets.
   Print the player's current balance after each roll.
   Also, add a text display for dice faces, not hard, but just makes it more fun!

6. Game Loop and Ending Condition:

   The game should continue in a loop, allowing the player to place new bets or exit the game until they run out of virtual currency or choose to exit.

7. Input Validation:

   Ensure all user inputs are valid (e.g., can’t bet more money than the player has, only accept valid menu options, and adhere to bet limits).

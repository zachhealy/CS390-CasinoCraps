        IDENTIFICATION DIVISION.
        PROGRAM-ID. CrapsGame.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 die1             PIC 9.
        01 die2             PIC 9.
        01 diceTotal        PIC 99.
        01 point            PIC 99.
        01 doub             PIC 9 VALUE 2.
        01 win              PIC X VALUE 'N'.
        01 rollAgain        PIC X VALUE 'Y'.
        01 passLineBet      PIC X VALUE 'N'.
        01 DontpassLineBet  PIC X VALUE 'N'.
        01 Comebet          PIC X VALUE 'N'.
        01 Dontcomebet      PIC X VALUE 'N'.
        01 validBet         PIC X VALUE 'N'.
        01 pointCheck       PIC X VALUE 'N'.
        01 choice           PIC 9999999999.
        01 bAmou            PIC 9999999999.
        01 cbAm             PIC 99999.
        01 cbAmTot          PIC 99999.
        01 dcbAm            PIC 99999.
        01 dcbAmTot         PIC 99999.
        01 bal              PIC 9999 VALUE 500.
        01 maxB             PIC 999 VALUE 200.
        01 minB             PIC 99 VALUE 10.
        01 seed             PIC 9999999999.
        01 seed2            PIC 9999999999.
        
        
        PROCEDURE DIVISION.
            PERFORM INITIALIZE-GAME.
            DISPLAY 'WELCOME TO THE CASINO!'
            DISPLAY 'Here to play CRAPS?'
            DISPLAY 'We have a lovely table, run by Mr. COBOL'
            DISPLAY 'Please, have a seat and get started!'
            DISPLAY '------------------------'
        
            PERFORM UNTIL rollAgain = 'N'
                DISPLAY 'Your bal: ' bal
                DISPLAY '------------------------'
                DISPLAY '1. Pass Line Bet'
                DISPLAY "2. Dont Pass Line Bet"
                DISPLAY '3. Quit'
                ACCEPT choice
        
                EVALUATE choice
                    WHEN 1
                        MOVE 'N' to validBet
                        PERFORM PASS-LINE-BET
                    WHEN 2
                        MOVE 'N' to validBet
                        PERFORM DONT-PASS-LINE-BET
                    WHEN 3
                        MOVE 'N' TO rollAgain
                    WHEN OTHER
                        DISPLAY 'Invalid choice. Try again.'
        
                END-EVALUATE
        
                IF rollAgain NOT = 'N'
                    IF choice = 1 OR choice = 2
                      PERFORM PLAY-CRAPS
                    END-IF
                END-IF
      
                IF bal < minB
                  DISPLAY 'It appears you have run dry...'
                  DISPLAY 'Maybe its best we part ways here'
                  MOVE 'N' TO rollAgain
                END-IF
            END-PERFORM.
        
            DISPLAY 'Thanks for playing!'
        
            STOP RUN.
        
        INITIALIZE-GAME.
            MOVE 'Y' TO rollAgain
            MOVE 0 TO point
            MOVE 'N' TO passLineBet
            MOVE 'N' TO DontpassLineBet
            MOVE 'N' TO Comebet
            MOVE 'N' TO Dontcomebet.
        
        PASS-LINE-BET.
          PERFORM UNTIL validBet = 'Y'
            DISPLAY 'Enter a bet amount: '
            ACCEPT bAmou
            IF bAmou <= maxB AND bAmou >= minB AND bAmou <= bal THEN
              MOVE 'Y' TO validBet
              SUBTRACT bAmou FROM bal
            ELSE
              DISPLAY 'Invalid choice. Try again.'
          END-PERFORM.
        
        DONT-PASS-LINE-BET.
          PERFORM UNTIL validBet = 'Y'
            DISPLAY 'Enter a bet amount: '
            ACCEPT bAmou
            IF bAmou <= maxB AND bAmou >= minB AND bAmou <= bal THEN
              MOVE 'Y' TO validBet
              SUBTRACT bAmou FROM bal
            ELSE
              DISPLAY 'Invalid choice. Try again.'
          END-PERFORM.
        
        COME-BET.
          MOVE 'Y' TO Comebet
          DISPLAY 'Current Balance: ' bal
          PERFORM UNTIL validBet = 'Y'
            DISPLAY 'Enter a bet amount: '
            ACCEPT cbAm
            IF cbAm <= maxB AND cbAm >= minB AND cbAm <= bal THEN
              MOVE 'Y' TO validBet
              SUBTRACT cbAm FROM bal
              ADD cbAm to cbAmTot
            ELSE
              DISPLAY 'Invalid choice. Try again.'
          END-PERFORM.
        
        DONT-COME-BET.
          MOVE 'Y' TO Dontcomebet
          DISPLAY 'Current Balance: ' bal
          PERFORM UNTIL validBet = 'Y'
            DISPLAY 'Enter a bet amount: '
            ACCEPT dcbAm
            IF dcbAm <= maxB AND dcbAm >= minB AND dcbAm <= bal THEN
              MOVE 'Y' TO validBet
              SUBTRACT dcbAm FROM bal
              ADD dcbAm TO dcbAmTot
            ELSE
              DISPLAY 'Invalid choice. Try again.'
          END-PERFORM.
        
        PLAY-CRAPS.
            PERFORM ROLL-DICE
            EVALUATE diceTotal
                WHEN 7
                    IF choice = 1
                        PERFORM HANDLE-WIN
                    ELSE 
                        PERFORM HANDLE-LOSS
                WHEN 11
                    IF choice = 1
                        PERFORM HANDLE-WIN
                    ELSE 
                        PERFORM HANDLE-LOSS
                WHEN 2
                    IF choice = 2
                        PERFORM HANDLE-WIN
                    ELSE 
                        PERFORM HANDLE-LOSS
                WHEN 3
                    IF choice = 2
                        PERFORM HANDLE-WIN
                    ELSE 
                        PERFORM HANDLE-LOSS
                WHEN 12
                    IF choice = 2
                        PERFORM HANDLE-WIN
                    ELSE 
                        PERFORM HANDLE-LOSS
                WHEN OTHER
                    PERFORM POINT-ROLL
            END-EVALUATE.
        
        ROLL-DICE.
            MOVE FUNCTION CURRENT-DATE(9:8) TO seed
            MOVE FUNCTION CURRENT-DATE(8:7) TO seed2
            COMPUTE die1 = FUNCTION RANDOM(seed) * 6 + 1
            COMPUTE die2 = FUNCTION RANDOM(seed2) * 6 + 1
        
            EVALUATE die1
                WHEN 1
                    DISPLAY "+-------+"
                    DISPLAY "|       |"
                    DISPLAY "|   *   |"
                    DISPLAY "|       |"
                    DISPLAY "+-------+"
                WHEN 2
                    DISPLAY "+-------+"
                    DISPLAY "|     * |"
                    DISPLAY "|       |"
                    DISPLAY "| *     |"
                    DISPLAY "+-------+"
                WHEN 3
                    DISPLAY "+-------+"
                    DISPLAY "|     * |"
                    DISPLAY "|   *   |"
                    DISPLAY "| *     |"
                    DISPLAY "+-------+"
                WHEN 4
                    DISPLAY "+-------+"
                    DISPLAY "| *   * |"
                    DISPLAY "|       |"
                    DISPLAY "| *   * |"
                    DISPLAY "+-------+"
                WHEN 5
                    DISPLAY "+-------+"
                    DISPLAY "| *   * |"
                    DISPLAY "|   *   |"
                    DISPLAY "| *   * |"
                    DISPLAY "+-------+"
                WHEN 6
                    DISPLAY "+-------+"
                    DISPLAY "| *   * |"
                    DISPLAY "| *   * |"
                    DISPLAY "| *   * |"
                    DISPLAY "+-------+"
                WHEN OTHER
                    DISPLAY "Invalid value for the first random number"
            END-EVALUATE.
        
            EVALUATE die2
                WHEN 1
                    DISPLAY "+-------+"
                    DISPLAY "|       |"
                    DISPLAY "|   *   |"
                    DISPLAY "|       |"
                    DISPLAY "+-------+"
                WHEN 2
                    DISPLAY "+-------+"
                    DISPLAY "|     * |"
                    DISPLAY "|       |"
                    DISPLAY "| *     |"
                    DISPLAY "+-------+"
                WHEN 3
                    DISPLAY "+-------+"
                    DISPLAY "|     * |"
                    DISPLAY "|   *   |"
                    DISPLAY "| *     |"
                    DISPLAY "+-------+"
                WHEN 4
                    DISPLAY "+-------+"
                    DISPLAY "| *   * |"
                    DISPLAY "|       |"
                    DISPLAY "| *   * |"
                    DISPLAY "+-------+"
                WHEN 5
                    DISPLAY "+-------+"
                    DISPLAY "| *   * |"
                    DISPLAY "|   *   |"
                    DISPLAY "| *   * |"
                    DISPLAY "+-------+"
                WHEN 6
                    DISPLAY "+-------+"
                    DISPLAY "| *   * |"
                    DISPLAY "| *   * |"
                    DISPLAY "| *   * |"
                    DISPLAY "+-------+"
                WHEN OTHER
                    DISPLAY "Invalid value for the second random number"
            END-EVALUATE.
        
            COMPUTE diceTotal = die1 + die2
            DISPLAY 'You rolled a ' die1 ' and a ' die2 '.' 
            DISPLAY 'Total: ' diceTotal
            DISPLAY '--'.
        
        HANDLE-WIN.
            DISPLAY 'You win!'
            COMPUTE bAmou = bAmou * doub
            COMPUTE bal = bal + bAmou
            IF Comebet = 'Y' THEN
                COMPUTE cbAmTot = cbAmTot * doub
                COMPUTE bal = bal + cbAmTot
            IF Dontcomebet = 'Y' THEN
                COMPUTE dcbAmTot = dcbAmTot * doub
                COMPUTE bal = bal + dcbAmTot.
        
        HANDLE-LOSS.
            MOVE 0 TO cbAm
            MOVE 0 TO Dontcomebet
            DISPLAY 'You lose.'.
        
        
        POINT-DISP.
            DISPLAY 'Point'
            IF point = 4
                DISPLAY 'ON     4'
            ELSE
                DISPLAY '       4'
            END-IF
        
            IF point = 5
                DISPLAY 'ON     5'
            ELSE
                DISPLAY '       5'
            END-IF
        
            IF point = 6
                DISPLAY 'ON     SIX'
            ELSE
                DISPLAY '       SIX'
            END-IF
        
            IF point = 8
                DISPLAY 'ON     8'
            ELSE
                DISPLAY '       8'
            END-IF
        
            IF point = 9
                DISPLAY 'ON     NINE'
            ELSE
                DISPLAY '       NINE'
            END-IF
        
            IF point = 10
                DISPLAY 'ON     10'
            ELSE
                DISPLAY '       10'
            END-IF
  
            DISPLAY '============='
            DISPLAY 'Dont Come: ' dcbAmTot
            DISPLAY 'Come: ' cbAmTot
            DISPLAY '============='.
      
        POINT-ROLL.
            MOVE diceTotal TO point
            MOVE 'N' TO pointCheck
            PERFORM UNTIL pointCheck = 'Y'
              DISPLAY 'Point is on: ' point
              DISPLAY '---------------------'
              PERFORM POINT-DISP
              DISPLAY '1. Roll for point'
              DISPLAY '2. Come Bet'
              DISPLAY '3. Dont Come Bet'
              DISPLAY '4. Quit'
              ACCEPT choice
        
              EVALUATE choice
                  WHEN 1
                      PERFORM ROLL-DICE
                      IF diceTotal = point
                          IF Comebet = 'Y'
                              PERFORM HANDLE-WIN
                              MOVE 'Y' TO pointCheck
                              MOVE 'N' TO Comebet
                          ELSE 
                              PERFORM HANDLE-LOSS
                              MOVE 'Y' TO pointCheck
                      ELSE IF diceTotal = 7
                          IF Dontcomebet = 'Y'
                              PERFORM HANDLE-WIN
                              MOVE 'Y' TO pointCheck
                              MOVE 'N' TO Dontcomebet
                          ELSE 
                              PERFORM HANDLE-LOSS
                              MOVE 'Y' TO pointCheck
                      END-IF
        
                  WHEN 2
                      IF bal > minB
                        MOVE 'N' to validBet
                        PERFORM COME-BET
                      ELSE 
                        DISPLAY 'Insufficent Funds: Please press 1'
                      END-IF
                  WHEN 3
                      IF bal > minB
                        MOVE 'N' to validBet
                        PERFORM DONT-COME-BET
                      ELSE 
                        DISPLAY 'Insufficent Funds: Please press 1' 
                      END-IF
                  WHEN 4
                      MOVE 'N' TO rollAgain
                      MOVE 'Y' TO pointCheck
                  WHEN OTHER
                      DISPLAY 'Invalid choice. Try again.'
              END-EVALUATE
            END-PERFORM.
        
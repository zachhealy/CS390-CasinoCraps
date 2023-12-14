program CrapsSimulation
  implicit none
  
  integer :: balance, bet, point, diceSum, comeOut, numOfRolls, maxBet, minBet, add, total
  logical :: ENDGame
  character(len=1) :: playAgain
  
  ! Initialize balance
  DATA balance/1000/
  DATA maxBet/200/
  DATA minBet/10/
  
  DO
    ! Reset variables for a new round
    numOfRolls = 0
    ENDGame = .false.
    
    ! Ask the player for the bet amount
    WRITE (*, *) '---------------------'
    WRITE (*, *) 'WELCOME TO THE CRAPS TABLE:'
    WRITE (*, *) 'Table has a Minimum of $10 and a Maximum of $200'
    WRITE (*, *) 'Your current balance: $', balance
    WRITE (*, *) 'Enter your bet amount: '
    WRITE (*, *) '---------------------'
    read *, bet
    balance = balance - bet
    total = bet
    ! Validate the bet amount
    IF (bet .LT. minBet .OR. bet .GT. balance .OR. bet.GT.maxBet) THEN
      WRITE (*, *) 'Invalid bet amount. Please enter a bet between 1 and your current balance.'
      cycle  ! Skip to the next iteration of the loop
    END IF


    WRITE (*, *) '---------------------'
    ! Main game loop
    DO WHILE (.NOT. ENDGame)
      numOfRolls = numOfRolls + 1
      
      ! Simulate the roll of two six-sided dice
      CALL rollDice(diceSum)
      
      IF (numOfRolls .EQ. 1) THEN
        ! Come-out roll
        comeOut = diceSum
        IF (comeOut .EQ. 7 .OR. comeOut .EQ. 11) THEN
          ! Win on a natural
          balance = balance + bet
          WRITE (*, *) 'You rolled a', comeOut, ' (Natural)! You win $', bet, '!'
          ENDGame = .true.
        ELSEIF (comeOut .EQ. 2 .OR. comeOut .EQ. 3 .OR. comeOut .EQ. 12) THEN
          ! Lose on craps
          WRITE (*, *) 'You rolled a', comeOut, ' (Craps). You lose $', bet, '!'
          ENDGame = .true.
        ELSE
          ! Point phase
          point = comeOut
          WRITE (*, *) 'Point is set to', point
        END IF
      ELSE
        ! Point phase
        IF (diceSum .EQ. 7) THEN
          ! Lose IF 7 is rolled before the point
          
          WRITE (*, *) 'You rolled a 7. You lose $', total, '!'
          ENDGame = .true.
        ELSE IF (diceSum .EQ. point) THEN
          ! Win IF the point is rolled
          balance = balance + total
          WRITE (*, *) 'You rolled the point ', point, '! You win $', total, '!'
          ENDGame = .true.
        ELSE
          WRITE (*,*) 'Would you like to bet again? '
          READ *, playAgain
          IF (playAgain /= 'N' .AND. playAgain /= 'n') THEN
            WRITE (*, *) '---------------------'
            WRITE (*, *) 'Current balance: $', balance
            WRITE (*, *) 'Current total bet: $', total
            WRITE (*, *) 'Enter your bet amount: '
            WRITE (*, *) 'Minimum of $10, Maximum of $200'
            WRITE (*, *) '---------------------'
            READ *, add
            balance = balance - add
            total = total + add
            ENDGame = .false.
        END IF
      END IF
      END IF
    END DO
    
    ! Print final balance
    WRITE (*, *) 'Final balance: $', balance

    WRITE (*, *) '---------------------'
    
    ! Check IF the player can play another round
    IF (balance <= 0) THEN
      WRITE (*, *) 'Sorry, your balance is 0 or below. You cannot play anymore.'
      exit
    ELSE
      ! Ask the player IF they want to play another round
      WRITE (*, *) 'Do you want to play another round? (Y/N): '
      read *, playAgain
      IF (playAgain /= 'Y' .AND. playAgain /= 'y') THEN
        WRITE (*, *) ''
        exit
      END IF
    END IF
  END DO
  
contains

  SUBROUTINE rollDice(result)
    implicit none
    integer, intent(out) :: result
    integer :: die1, die2
    
    ! Simulate the roll of two six-sided dice
    die1 = int(6 * rand()) + 1
    die2 = int(6 * rand()) + 1

    IF (die1 .EQ. 1 .OR. die2 .EQ. 1) THEN
      WRITE (*, *) '--------'
      WRITE (*, *) '|       |'
      WRITE (*, *) '|   0   |'
      WRITE (*, *) '|       |'
      WRITE (*, *) '--------'
    END IF
    IF (die1 .EQ. 2 .OR. die2 .EQ. 2) THEN
      WRITE (*, *) '--------'
      WRITE (*, *) '| 0     |'
      WRITE (*, *) '|       |'
      WRITE (*, *) '|     0 |'
      WRITE (*, *) '--------'
    END IF
    IF (die1 .EQ. 3 .OR. die2 .EQ. 3) THEN
      WRITE (*, *) '--------'
      WRITE (*, *) '| 0     |'
      WRITE (*, *) '|   0   |'
      WRITE (*, *) '|     0 |'
      WRITE (*, *) '--------'
    END IF
    IF (die1 .EQ. 4 .OR. die2 .EQ. 4) THEN
      WRITE (*, *) '--------'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '|       |'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '--------'
    END IF
    IF (die1 .EQ. 5 .OR. die2 .EQ. 5) THEN
      WRITE (*, *) '--------'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '|   0   |'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '--------'
    END IF
    IF (die1 .EQ. 6 .OR. die2 .EQ. 6) THEN
      WRITE (*, *) '--------'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '| 0   0 |'
      WRITE (*, *) '--------'
    END IF
    
    ! Calculate the sum of the dice
    result = die1 + die2

  ! Print the roll
  WRITE (*, *) 'You rolled a', die1, ' and a', die2, ' (Total:', result, ')'

    WRITE (*, *) '---------------------'
    
    
  END SUBROUTINE rollDice

END program CrapsSimulation

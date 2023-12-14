open System

let mutable die1 = 0
let mutable die2 = 0
let mutable diceTotal = 0
let mutable point = 0
let mutable doub = 2
let mutable win = false
let mutable rollAgain = true
let mutable passLineBet = false
let mutable dontPassLineBet = false
let mutable comeBet = false
let mutable dontComeBet = false
let mutable validBet = false
let mutable pointCheck = false
let mutable choice = 0
let mutable bAmou = 0
let mutable cbAm = 0
let mutable cbAmTot = 0
let mutable dcbAm = 0
let mutable dcbAmTot = 0
let mutable bal = 500
let mutable maxB = 200
let mutable minB = 10

let rollDice () =
  let random = new Random()
  die1 <- random.Next(1, 7)
  die2 <- random.Next(1, 7)
  diceTotal <- die1 + die2

  if die1 = 1 then
    printfn "+-------+"
    printfn "|       |"
    printfn "|   *   |"
    printfn "|       |"
    printfn "+-------+"
  if die1 = 2 then
    printfn "+-------+"
    printfn "|     * |"
    printfn "|       |"
    printfn "| *     |"
    printfn "+-------+"
  if die1 = 3 then
    printfn "+-------+"
    printfn "|     * |"
    printfn "|   *   |"
    printfn "| *     |"
    printfn "+-------+"
  if die1 = 4 then
    printfn "+-------+"
    printfn "| *   * |"
    printfn "|       |"
    printfn "| *   * |"
    printfn "+-------+"
  if die1 = 5 then
    printfn "+-------+"
    printfn "| *   * |"
    printfn "|   *   |"
    printfn "| *   * |"
    printfn "+-------+"
  if die1 = 6 then
    printfn "+-------+"
    printfn "| *   * |"
    printfn "| *   * |"
    printfn "| *   * |"
    printfn "+-------+"

  if die2 = 1 then
    printfn "+-------+"
    printfn "|       |"
    printfn "|   *   |"
    printfn "|       |"
    printfn "+-------+"
  if die2 = 2 then
    printfn "+-------+"
    printfn "|     * |"
    printfn "|       |"
    printfn "| *     |"
    printfn "+-------+"
  if die2 = 3 then
    printfn "+-------+"
    printfn "|     * |"
    printfn "|   *   |"
    printfn "| *     |"
    printfn "+-------+"
  if die2 = 4 then
    printfn "+-------+"
    printfn "| *   * |"
    printfn "|       |"
    printfn "| *   * |"
    printfn "+-------+"
  if die2 = 5 then
    printfn "+-------+"
    printfn "| *   * |"
    printfn "|   *   |"
    printfn "| *   * |"
    printfn "+-------+"
  if die2 = 6 then
    printfn "+-------+"
    printfn "| *   * |"
    printfn "| *   * |"
    printfn "| *   * |"
    printfn "+-------+"

  printfn "Dice Total: %d" diceTotal

let rec getIntInput () =
  let mutable isValid = false
  let mutable result = 0
  
  while not isValid do
    let input = Console.ReadLine()
    if not (String.IsNullOrWhiteSpace(input)) && Int32.TryParse(input, &result) then
      isValid <- true
    else
      printfn "Invalid input. Please enter a valid integer: "
  result

let initializeGame () =
  rollAgain <- true
  point <- 0
  passLineBet <- false
  dontPassLineBet <- false
  comeBet <- false
  dontComeBet <- false

let passLineBetFunc () =
  validBet <- false
  while not validBet do
    printfn "Enter a bet amount: "
    bAmou <- getIntInput()

    if bAmou <= maxB && bAmou >= minB && bAmou <= bal then
      validBet <- true
      bal <- bal - bAmou
    else
      printfn "Invalid choice. Try again."

let dontPassLineBetFunc () =
  validBet <- false
  while not validBet do
    printfn "Enter a bet amount: "
    bAmou <- getIntInput()
    
    if bAmou <= maxB && bAmou >= minB && bAmou <= bal then
      validBet <- true
      bal <- bal - bAmou
    else
      printfn "Invalid choice. Try again."

let comeBetFunc () =
  comeBet <- true
  printfn "Current Balance: %d" bal
  validBet <- false
  while not validBet do
    printfn "Enter a bet amount: "
    cbAm <- getIntInput()
    if cbAm <= maxB && cbAm >= minB && cbAm <= bal then
      validBet <- true
      bal <- bal - cbAm
      cbAmTot <- cbAmTot + cbAm
    else
      printfn "Invalid choice. Try again."

let dontComeBetFunc () =
  dontComeBet <- true
  printfn "Current Balance: %d" bal
  validBet <- false
  while not validBet do
    printfn "Enter a bet amount: "
    dcbAm <- getIntInput()
    if dcbAm <= maxB && dcbAm >= minB && dcbAm <= bal then
      validBet <- true
      bal <- bal - dcbAm
      dcbAmTot <- dcbAmTot + dcbAm
    else
      printfn "Invalid choice. Try again."

let handleWin () =
  printfn "You win!"
  bAmou <- bAmou * doub
  bal <- bal + bAmou
  if comeBet then
    cbAmTot <- cbAmTot * doub
    bal <- bal + cbAmTot
  if dontComeBet then
    dcbAmTot <- dcbAmTot * doub
    bal <- bal + dcbAmTot

let handleLoss () =
  cbAm <- 0
  dontComeBet <- false
  printfn "You lose."

let pointDisp () =
  printfn "Point"
  if point = 4 then
    printfn "ON     4"
  else
    printfn "       4"

  if point = 5 then
    printfn "ON     5"
  else
    printfn "       5"

  if point = 6 then
    printfn "ON     SIX"
  else
    printfn "       SIX"

  if point = 8 then
    printfn "ON     8"
  else
    printfn "       8"

  if point = 9 then
    printfn "ON     NINE"
  else
    printfn "       NINE"

  if point = 10 then
    printfn "ON     10"
  else
    printfn "       10"

  printfn "============="
  printfn "Dont Come: %d" dcbAmTot
  printfn "Come: %d" cbAmTot
  printfn "============="

let pointRoll () =
  point <- diceTotal
  pointCheck <- false
  while not pointCheck do
    printfn "Point is on: %d" point
    printfn "---------------------"
    pointDisp ()
    printfn "1. Roll for point"
    printfn "2. Come Bet"
    printfn "3. Dont Come Bet"
    printfn "4. Quit"
    
    choice <- getIntInput()
    
    match choice with
    | 1 ->
      rollDice ()
      if diceTotal = point then
        if comeBet then
          handleWin ()
          pointCheck <- true
          comeBet <- false
        else
          handleLoss ()
          pointCheck <- true
      elif diceTotal = 7 then
        if dontComeBet then
          handleWin ()
          pointCheck <- true
          dontComeBet <- false
        else
          handleLoss ()
          pointCheck <- true
    | 2 ->
      if bal > minB then
        validBet <- false
        comeBetFunc ()
      else
        printfn "Insufficient Funds: Please press 1"
    | 3 ->
      if bal > minB then
          validBet <- false
          dontComeBetFunc ()
      else
          printfn "Insufficient Funds: Please press 1"
    | 4 ->
      rollAgain <- false
      pointCheck <- true
    | _ ->
      printfn "Invalid choice. Try again."
      

let playCraps () =
  rollDice ()
  
  match diceTotal with
  | 7 | 11 ->
    if choice = 1 then
      handleWin ()
    else
      handleLoss ()
  | 2 | 3 | 12 ->
    if choice = 2 then
      handleWin ()
    else
      handleLoss ()
  | _ ->
    pointRoll ()


let rec mainLoop () =
  initializeGame ()
  printfn "WELCOME TO THE CASINO!"
  printfn "Here to play CRAPS?"
  printfn "We have a lovely table, run by Mr. Sharp"
  printfn "Please, have a seat and get started!"
  printfn "------------------------"
  while rollAgain do
    printfn "Your bal: %d" bal
    printfn "------------------------"
    printfn "1. Pass Line Bet"
    printfn "2. Dont Pass Line Bet"
    printfn "3. Quit"
    
    choice <- getIntInput()
    
    match choice with
    | 1 ->
      validBet <- false
      passLineBetFunc ()
      if rollAgain then
        if choice = 1 || choice = 2 then
          playCraps ()
    | 2 ->
      validBet <- false
      dontPassLineBetFunc ()
      if rollAgain then
        if choice = 1 || choice = 2 then
          playCraps ()
    | 3 ->
      rollAgain <- false
    | _ ->
      printfn "Invalid choice. Try again."

    if bal < minB then
      printfn "It appears you have run dry..."
      printfn "Maybe it's best we part ways here"
      rollAgain <- false
      
  printfn "Thanks for playing!"

[<EntryPoint>]
let main argv =
    mainLoop ()
    0 // return an integer exit code

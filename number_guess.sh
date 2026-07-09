#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MIN=1
MAX=1000
RANDOM_NUMBER=$(($RANDOM % ($MAX - $MIN + 1) + $MIN))

PLAY_GAME(){
  echo -e "\nGuess the secret number between 1 and 1000:"
  read INPUT_NUMBER
  
  # Inicializamos en 1 porque el 'read' de arriba ya es el primer intento
  NUMBER_OF_GUESS=1

  until [[ $INPUT_NUMBER =~ ^[0-9]+$ ]]
  do
    echo "That is not an integer, guess again:"
    read INPUT_NUMBER
  done

  until [[ $INPUT_NUMBER -eq $RANDOM_NUMBER ]]
  do
    ((NUMBER_OF_GUESS++))
    if [[ $INPUT_NUMBER -gt $RANDOM_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
      read INPUT_NUMBER
    else
      echo "It's higher than that, guess again:"
      read INPUT_NUMBER
    fi

    # Si vuelven a meter algo que no es número dentro del juego, lo validamos
    until [[ $INPUT_NUMBER =~ ^[0-9]+$ ]]
    do
      echo "That is not an integer, guess again:"
      read INPUT_NUMBER
    done
  done

  # Mensaje exacto requerido por el test
  echo -e "\nYou guessed it in $NUMBER_OF_GUESS tries. The secret number was $RANDOM_NUMBER. Nice job!"

  # Actualizar número de juegos jugados
  INSERT_UP_GRADE="$($PSQL "UPDATE games SET games_played = games_played + 1 WHERE username='$USER_NAME'")"

  # Condicional para evaluar el best_game
  CURRENT_BEST_GAME="$($PSQL "SELECT best_game FROM games WHERE username='$USER_NAME'")"
  if [[ $CURRENT_BEST_GAME -eq 0 || $NUMBER_OF_GUESS -lt $CURRENT_BEST_GAME ]]
  then
    UPDATE_BEST_GAME="$($PSQL "UPDATE games SET best_game = $NUMBER_OF_GUESS WHERE username='$USER_NAME'")"
  fi
}

# Obtener el nombre de usuario
echo "Enter your username:"
read USER_NAME

# Buscar en la base de datos si existe el usuario
GET_USER="$($PSQL "SELECT user_id FROM games WHERE username='$USER_NAME'")"

if [[ -z $GET_USER ]]
then
  # SI ES NUEVO: Se registra y muestra mensaje de bienvenida (con punto al final)
  INSERT_USER_NAME="$($PSQL "INSERT INTO games(username) VALUES('$USER_NAME')")"
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
else
  # SI YA EXISTE: Obtenemos sus datos y mostramos el mensaje de "Welcome back" usando Here-String (<<<)
  GET_THE_INFO_GAME="$($PSQL "SELECT games_played, best_game FROM games WHERE username='$USER_NAME'")" 
  
  while IFS="|" read GAMES_PLAYED BEST_GAME
  do
    echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done <<< "$GET_THE_INFO_GAME"
fi

# El juego se ejecuta una sola vez al final, sin importar si es nuevo o viejo
PLAY_GAME
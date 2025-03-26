rm(list = ls())
gc()
# Define a list of words 
words <- c('apple', 'banana', 'cherry', 'grape','strawberry')

#Randomly Select 1 Word from Word Bank Given 
secret_word <- sample(words,1)
secret_word <- unlist(strsplit(secret_word, ""))  # Split word into a vector of individual letters

#Initalize Game Variables 
guessed_word <- rep("_", length(secret_word)) #Creates a vector of underscores (_) with the same length as secret_word, representing unguessed letters.
attempts <- 6  # Max incorrect guesses
wrong_guesses <- c()

# Game loop
while (attempts > 0 && any(guessed_word == "_")) {
  cat("\nWord: ", paste(guessed_word, collapse = " "), "\n")
  cat("Attempts left:", attempts, "\n")
  cat("Wrong guesses: ", paste(wrong_guesses, collapse = ", "), "\n")
  
  # Get user input
  guess <- readline("Guess a letter: ")
  
  # Check if guess is in word
  if (guess %in% secret_word) {
    for (i in seq_along(secret_word)) {
      if (secret_word[i] == guess) {
        guessed_word[i] <- guess
      }
    }
  } else {
    if (!(guess %in% wrong_guesses)) {
      wrong_guesses <- c(wrong_guesses, guess)
      attempts <- attempts - 1
    }
  }
}

# Game over messages
if (all(guessed_word != "_")) {
  cat("\nCongratulations! You guessed the word:", paste(secret_word, collapse = ""), "\n")
} else {
  cat("\nGame Over! The word was:", paste(secret_word, collapse = ""), "\n")
}

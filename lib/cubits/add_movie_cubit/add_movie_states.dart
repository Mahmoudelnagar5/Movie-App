class AddMovieStates {}

class AddMovieInitialState extends AddMovieStates {}

class AddMovieLoadingState extends AddMovieStates {}

class AddMovieLoadedState extends AddMovieStates {}

class AddMovieErrorState extends AddMovieStates {
  String message;

  AddMovieErrorState(this.message);
}

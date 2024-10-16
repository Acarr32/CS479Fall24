void pianoMode() {
  if (currentState == State.Menu) {
    println(GetString("TestString"));
    currentState = State.Piano;
  }
}

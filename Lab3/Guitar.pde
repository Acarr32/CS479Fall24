void guitarMode() {
  if (currentState == State.Menu) {
    println(GetString("testString"));
    currentState = State.Guitar;
  }
}

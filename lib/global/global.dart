class Global {
  static String cookie = "";
  // e.g. connect.sid=s%3AFW2Mj8V0e6IBUzGAfCShZYFEUc8tTWP-.HaICI4UdKNlT5YZjevCPmFEEIXNAUwFN%2FJLOdqKPaI4
  static int loggedIn = 0;
  static updateCookie(String s) {
      cookie = s;
  }
}


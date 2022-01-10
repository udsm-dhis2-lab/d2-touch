// @flow
trimQuotes(String input) {
  var trimmingComplete = false;
  var beingTrimmed = input;
  while (!trimmingComplete) {
    final beforeTrimming = beingTrimmed.trim();
    beingTrimmed = beingTrimmed
        .replace(new RegExp(r'^' + "'" + r''), "")
        .replace(new RegExp(r'' + "'" + r'$'), "");
    beingTrimmed = beingTrimmed
        .replace(new RegExp(r'^"'), "")
        .replace(new RegExp(r'"$'), "");
    if (identical(beforeTrimming.length, beingTrimmed.length)) {
      trimmingComplete = true;
    }
  }
  return beingTrimmed;
}

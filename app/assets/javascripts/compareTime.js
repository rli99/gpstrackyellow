function compareTime(a, b) {
  if (a["time"] < b["time"]) {
    return -1
  } else if (a["time"] == b["time"]) {
    return 0
  } else {
    return 1
  }
}
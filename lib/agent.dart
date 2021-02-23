class Agent {
  String name;
  String imageName;
  String activePeriod;

  String get getName {
    return name;
  }

  set setName(String name) {
    this.name = name;
  }

  Agent({this.name, this.imageName, this.activePeriod});
}

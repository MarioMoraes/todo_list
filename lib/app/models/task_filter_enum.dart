enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return 'Today';
      case TaskFilterEnum.tomorrow:
        return 'Tomorrow';
      case TaskFilterEnum.week:
        return 'Week';
    }
  }
}

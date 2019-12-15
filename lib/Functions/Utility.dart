String timeAgo(DateTime datetime) {
  final intervals = {
    'an': 31536000,
    'mois': 2592000,
    'semaine': 604800,
    'jour': 86400,
    'heure': 3600,
    'minute': 60,
    // 'seconde': 1
  };
  final diff =datetime.difference(DateTime.now()).inSeconds * -1;
  if (diff < 59 && diff > 0) {
    return 'A l\instant';
  }

  for(int i=0; i<intervals.length; i++) {
    int current = (diff / intervals.values.toList()[i]).floor();
    if (current >= 1) {
      if (current == 1 || intervals.keys.toList()[i] == 'mois') {
        return 'Il y\'a '+current.toString()+' '+intervals.keys.toList()[i];
      }
      return 'Il y\'a '+current.toString()+' '+intervals.keys.toList()[i]+'s';
    }

  }
  return 'Dans le future';
}
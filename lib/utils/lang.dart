class Translator {
  static Map<int, String> bfbanStatusMap = {
    -3: 'neterr',
    -2: 'searching',
    -1: 'norecord',
    0: 'waiting',
    1: 'hacker',
    2: 'needprovidingproof',
    3: 'moss',
    4: 'invalid',
    5: 'checking',
    6: 'vote',
    7: 'null',
    8: 'pve',
  };

  static bfbanStatusTranslate(int bfbanStatus) {
    return bfbanStatusMap[bfbanStatus] ?? bfbanStatus.toString();
  }

  static appLocalizationsTranslate(String translated, String original,
      {String unableTranslatedKey = 'default'}) {
    return translated == unableTranslatedKey ? original : translated;
  }
}

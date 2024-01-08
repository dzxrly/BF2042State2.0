class Translator {
  static Map<String, String> gameMapMap = {
    'Discarded': '废弃之地',
    'Hourglass': '沙漏',
    'Breakaway': '分崩离析',
    'Kaleidescope': '万花筒',
    'Manifest': '货物仓单',
    'Orbital': '航天发射场',
    'Renewal': '涅槃',
    'Battle of the Bulge': '突出部之役',
    'Arica Harbor': '阿里卡港',
    'Valparaiso': '瓦尔帕莱索',
    'El Alamein': '阿拉曼',
    'Noshahr Canals': '诺沙运河',
    'Caspian Border': '里海边境',
    'Exposure': '曝光',
    'Stranded': '搁浅',
    'Spearhead': '急先锋',
    'Flashpoint': '闪点',
    'Reclaimed': '重生',
    'Redacted': '删隐地区',
  };

  static Map<String, String> gamemodeMap = {
    'Breakthrough': '突破',
    'Breakthrough Large': '突破 (大型)',
    'Conquest': '征服',
    'Conquest Large': '征服 (大型)',
    'Hazard Zone': '危险地带',
    'Hazard Zone Large': '危险地带 (大型)',
    'Rush': '突袭',
    'Custom': '门户自定义',
  };

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

  static gameMapTranslate(String gameMap) {
    return gameMapMap[gameMap] ?? gameMap;
  }

  static gamemodeTranslate(String gamemode) {
    return gamemodeMap[gamemode] ?? gamemode;
  }

  static bfbanStatusTranslate(int bfbanStatus) {
    return bfbanStatusMap[bfbanStatus] ?? bfbanStatus.toString();
  }
}

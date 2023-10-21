class Translator {
  static Map<String, String> classesMap = {
    'Mackay': '麦凯',
    'Irish': '爱尔兰佬',
    'Sundance': '日舞',
    'Dozer': '推土机',
    'Paik': '白智秀',
    'Falck': '法尔克',
    'Angel': '天使',
    'Boris': '鲍里斯',
    'Casper': '卡斯帕',
    'Rao': '拉奥',
    'Lis': '莉丝',
    'Crawford': '克劳福德',
    'Zain': '扎因',
    'Blasco': '布拉斯科',
    'BF3 Support': 'BF3支援兵',
    'BF3 Engineer': 'BF3工程兵',
    'BF3 Recon': 'BF3侦察兵',
    'BF3 Assault': 'BF3突击兵',
    'BC2 Assault': 'BC2突击兵',
    'BC2 Medic': 'BC2医疗兵',
    'BC2 Engineer': 'BC2工程兵',
    'BC2 Recon': 'BC2侦察兵',
    '1942 Assault': '1942突击兵',
    '1942 Medic': '1942医疗兵',
    '1942 Engineer': '1942工程兵',
    '1942 Scout': '1942侦察兵',
    '1942 Anti-tank': '1942反坦克兵',
  };

  static classesTranslate(String className) {
    return classesMap[className] ?? className;
  }
}

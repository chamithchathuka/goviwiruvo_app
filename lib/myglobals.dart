class MyGlobals {
  static final AppName = "ගොවි විරුවෝ";
  static final AppVersion = "1";

  final PUBLIC_KEY =
      "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgackVmxB4IPC4IKuMfrC"+
          "TQpm11hLVKfN3BOkbFD9W1HtuTUfbRzp1PeZQFzz5ps4ul21IjgELWK1wdh7eDht"+
          "CRBMx2Qlx8XgubXHvj68SuRRs6YxUVEL6NZjh8DqA/ZOmfHqARgfz8pY2mZEeWgr"+
          "BS+ptOYPvc195lEA+uRcmpXbuZEnzQpU5SBZVq8C4fCUm2DiL0DEPrwLrwfPFZXd"+
          "24BbxIj/iGN2bfoYKrGRQWJiq8L2pEwt18Cx4ADC7KIPqPfpYWItoCoonKevemk8"+
          "+dN5KwUHLEghJpmNmbyvQgstVxmK28EehPP+v7FZKMPcdWdZmcnowz934yFklWA+"+
          "eQIDAQAB";

  static const hostURL = "https://online.plc.lk/pil-0.0.1-SNAPSHOT";
//   static const hostURL = "http://localhost:8080";
//   static const hostURL = "http://455b59ba.ngrok.io";

  static const SECURITY_SETTINGS_PAGE_NAME = "Security Settings";
  static const HOME_PAGE_NAME = "Security Settings";

  static final List<String> USER_ROLES = <String>[
    "Farmer",
    "Coodinator",
//  "Trial Calculation",
//  "Credit Approval",
  ];

  static final List<String> MENU_IMAGES = <String>[
    "images/leadback.jpeg",
    "images/street.jpeg",
    "images/money.jpeg",
  ];

  static final List<String> MENU_PATHS = <String>[
    "/lead",
    "/addfarmer",
  ];


  static const List<int> BOUNDARY_CHARACTERS = const <int>[
    39, 40, 41, 43, 95, 44, 45, 46, 47, 58, 61, 63, 48, 49, 50, 51, 52, 53, 54,
    55, 56, 57, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103,
    104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,
    119, 120, 121, 122
  ];
}
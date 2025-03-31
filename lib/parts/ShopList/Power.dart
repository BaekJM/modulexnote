final List<String> PowerModules = [
  "なし",
  //ABB
  "ABB_バス電源160mA",
  "ABB_バス電源320mA",
  "ABB_バス電源640mA",
  //Jung
  "JUNG_バス電源320mA + IPS",
  //Schneide
  "Schneider_バス電源640mA",
  //GVS
  "GVS_バス電源640mA",
  //HDL
  "HDL_バス電源960mA",
];
final List<double> PowerCash = [
  0, //なし
  //ABB
  49150, //ABB_バス電源160mA
  36750, //ABB_バス電源320mA
  22610, //ABB_バス電源640mA
  //Jung
  89680, //JUNG_バス電源320mA + IPS
  //Schneide
  41330, //Schneider_バス電源640mA
  //GVS
  32510, //GVS_バス電源640mA
  //HDL
  13540, //HDL_バス電源960mA
];

final List<String> PowerCode = [
  "null",  //なし
  //ABB
  "SV/S30.160.1.1",  //ABB_バス電源160mA
  "SV/S30.320.2.1",  //ABB_バス電源320mA
  "SV/S30.640.5.1",  //ABB_バス電源640mA
  //Jung
  "203201SIPSR",  //JUNG_バス電源320mA + IPS
  //Schneide
  "MTN684064",  //Schneider_バス電源640mA
  //GVS
  "BBPS-02/640.1",  //GVS_バス電源640mA
  //HDL
  "HDL-M/P960.1",  //HDL_バス電源960mA
];

final List<String> DC24Modules = [
  "なし",
  //ABB
  "ABB DC24",
];
final List<double> DC24Cash = [
  0, //なし
  //ABB
  13010, //ABB DC24
];
final List<String> DC24Code = [
  "null",
  //ABB
  "CP-D24/2.5", //ABB DC24
];


enum Position {
  point1(name: '하구둑8번교각', code: "2022B4a"),
  point2(name: '하구둑10번교각', code: "2022B4b"),
  point3(name: '갑문상류', code: "2022B4c"),
  point4(name: '을숙도대교P3', code: "2022B5a"),
  point5(name: '을숙도대교P20', code: "2022B5b"),
  point6(name: '낙동강 하구둑', code: "2022B1a"),
  point7(name: '낙동대교', code: "2022B2a"),
  point8(name: '우안배수문', code: "2022B3a"),
  point9(name: '낙동강상류3km', code: "2022A1a"),
  point10(name: '낙동강상류7.5km', code: "2022A1b"),
  point11(name: '낙동강상류9km', code: "2022A2b"),
  point12(name: '낙동강상류10km', code: "2022A2a"),
  ;

  final String name;
  final String code;

  const Position({required this.name, required this.code});
}

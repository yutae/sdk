// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@pragma('dart2js:noInline')
/*member: foo1:function() {
  return 72;
}*/
foo1() {
  var a = 'Hello';
  var b = 0;
  return a.codeUnitAt(b);
  // Constant folds to 'return 72;'
}

@pragma('dart2js:noInline')
/*spec.member: foo2:function() {
  return C.JSString_methods.codeUnitAt$1("Hello", H._asInt(1.5));
}*/
/*prod.member: foo2:function() {
  return C.JSString_methods.codeUnitAt$1("Hello", 1.5);
}*/
/*canary.member: foo2:function() {
  return B.JSString_methods.codeUnitAt$1("Hello", A._asInt(1.5));
}*/
foo2() {
  var a = 'Hello';
  dynamic b = 1.5;
  return a.codeUnitAt(b);
  // No folding of index type error.
}

@pragma('dart2js:noInline')
/*spec|prod.member: foo3:function() {
  return C.JSString_methods._codeUnitAt$1("Hello", 55);
}*/
/*canary.member: foo3:function() {
  return B.JSString_methods._codeUnitAt$1("Hello", 55);
}*/
foo3() {
  var a = 'Hello';
  dynamic b = 55;
  return a.codeUnitAt(b);
  // No folding of index range error.
}

/*member: main:ignore*/
main() {
  foo1();
  foo2();
  foo3();
}

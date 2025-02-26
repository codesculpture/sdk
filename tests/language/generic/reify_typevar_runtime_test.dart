// TODO(multitest): This was automatically migrated from a multitest and may
// contain strange or dead code.

// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:expect/expect.dart";

class C<T> {
  final x;
  C([this.x]);

  static staticFunction(bool b) => null;
  factory C.factoryConstructor(bool b) => new C(null);
  C.redirectingConstructor(bool b) : this(null);
  C.ordinaryConstructor(bool b) : x = null;
}

main() {
  Expect.equals(null, C.staticFunction(false));
  Expect.equals(null, new C.factoryConstructor(false).x);
  Expect.equals(null, new C.redirectingConstructor(false).x);
  Expect.equals(null, new C.ordinaryConstructor(false).x);
}

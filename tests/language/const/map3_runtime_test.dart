// TODO(multitest): This was automatically migrated from a multitest and may
// contain strange or dead code.

// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:expect/expect.dart";

class A {
  static const b = const B();
}

class B implements A {
  const B();
}

main() {
  // It is a compile-time error if the key type overrides operator ==.
  dynamic m = const {A.b: 42};
  Expect.equals(42, m[const B()]);

  m = const {"foo": 99, A.b: 499};
  Expect.equals(499, m[const B()]);
}

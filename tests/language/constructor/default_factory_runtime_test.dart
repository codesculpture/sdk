// TODO(multitest): This was automatically migrated from a multitest and may
// contain strange or dead code.

// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:expect/expect.dart";

// Dart test program for testing default factories.

abstract class Vehicle {}

class Bike implements Vehicle, GoogleOne {
  Bike.redOne() {}
}

abstract class SpaceShip {
  factory SpaceShip() = GoogleOne;
}

class GoogleOne implements SpaceShip {
  GoogleOne.internal_() {}
  factory GoogleOne() {
    return new GoogleOne.internal_();
  }
  factory GoogleOne.Vehicle() {
    return new Bike.redOne();
  }
}

main() {
  Expect.equals(true, (new Bike.redOne()) is Bike);
  Expect.equals(true, (new SpaceShip()) is GoogleOne);
}

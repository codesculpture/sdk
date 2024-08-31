// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/error/ffi_code.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../dart/resolution/context_collection_resolution.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(FfiLeafNativeAddressNoCascade);
  });
}

@reflectiveTest
class FfiLeafNativeAddressNoCascade extends PubPackageResolutionTest {
  test_defined_getters_of_address() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>(isLeaf: true)
external void myNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNative(buff.address.address);
}
''', [error(CompileTimeErrorCode.ARGUMENT_TYPE_NOT_ASSIGNABLE, 196, 20)]);
  }

  test_defined_getters_of_address_cast() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>(isLeaf: true)
external void myNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNative(buff.address.cast().address);
}
''', [error(CompileTimeErrorCode.ARGUMENT_TYPE_NOT_ASSIGNABLE, 196, 27)]);
  }

  test_undefined_getters_of_address() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>(isLeaf: true)
external void myNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNative(buff.address.doesntExist);
}
''', [error(CompileTimeErrorCode.UNDEFINED_GETTER, 209, 11)]);
  }

  test_undefined_getters_of_address_cast() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>(isLeaf: true)
external void myNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNative(buff.address.cast().doesntExist);
}
''', [error(CompileTimeErrorCode.UNDEFINED_GETTER, 216, 11)]);
  }

  test_non_leaf_defined_getters_of_address() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>()
external void myNonNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNonNative(buff.address.address);
}
''', [
      error(CompileTimeErrorCode.ARGUMENT_TYPE_NOT_ASSIGNABLE, 190, 20),
      error(FfiCode.ADDRESS_POSITION, 195, 7)
    ]);
  }

  test_non_leaf_defined_getters_of_address_cast() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>()
external void myNonNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNonNative(buff.address.cast().address);
}
''', [
      error(CompileTimeErrorCode.ARGUMENT_TYPE_NOT_ASSIGNABLE, 190, 27),
      error(FfiCode.ADDRESS_POSITION, 195, 7)
    ]);
  }

  test_non_leaf_undefined_getters_of_address() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>()
external void myNonNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNonNative(buff.address.doesntExist);
}
''', [
      error(FfiCode.ADDRESS_POSITION, 195, 7),
      error(CompileTimeErrorCode.UNDEFINED_GETTER, 203, 11),
    ]);
  }

  test_non_leaf_undefined_getters_of_address_cast() async {
    await assertErrorsInCode('''
import 'dart:ffi';
import 'dart:typed_data';

@Native<Void Function(Pointer<Void>)>()
external void myNonNative(Pointer<Void> buff);

void main() {
  final buff = Int8List(1);
  myNonNative(buff.address.cast().doesntExist);
}
''', [
      error(FfiCode.ADDRESS_POSITION, 195, 7),
      error(CompileTimeErrorCode.UNDEFINED_GETTER, 210, 11)
    ]);
  }
}

// RUN: %empty-directory(%t)
// RUN: %target-swift-frontend %s -typecheck -module-name Functions -emit-cxx-header-path %t/functions.h
// RUN: %FileCheck %s < %t/functions.h

// RUN: %check-cxx-header-in-clang -std=c++14 %t/functions.h
// RUN: %check-cxx-header-in-clang -std=c++17 %t/functions.h

// CHECK-LABEL: namespace Functions {

// CHECK-LABEL: namespace _impl {

// CHECK: extern "C" void $s9Functions17passIntReturnVoid1xys5Int32V_tF(int x) noexcept SWIFT_CALL; // passIntReturnVoid(x:)
// CHECK: extern "C" int $s9Functions016passTwoIntReturnD01x1ys5Int32VAF_AFtF(int x, int y) noexcept SWIFT_CALL; // passTwoIntReturnInt(x:y:)
// CHECK: extern "C" int $s9Functions016passTwoIntReturnD10NoArgLabelys5Int32VAD_ADtF(int, int) noexcept SWIFT_CALL; // passTwoIntReturnIntNoArgLabel(_:_:)
// CHECK: extern "C" int $s9Functions016passTwoIntReturnD19NoArgLabelParamNameys5Int32VAD_ADtF(int x2, int y2) noexcept SWIFT_CALL; // passTwoIntReturnIntNoArgLabelParamName(_:_:)
// CHECK: extern "C" void $s9Functions014passVoidReturnC0yyF(void) noexcept SWIFT_CALL; // passVoidReturnVoid()

// CHECK: }

public func passIntReturnVoid(x: CInt) { print("passIntReturnVoid \(x)") }

// CHECK: inline void passIntReturnVoid(int x) noexcept {
// CHECK: return _impl::$s9Functions17passIntReturnVoid1xys5Int32V_tF(x);
// CHECK: }

public func passTwoIntReturnInt(x: CInt, y: CInt) -> CInt { return x + y }

// CHECK: inline int passTwoIntReturnInt(int x, int y) noexcept SWIFT_WARN_UNUSED_RESULT {
// CHECK: return _impl::$s9Functions016passTwoIntReturnD01x1ys5Int32VAF_AFtF(x, y);
// CHECK: }

public func passTwoIntReturnIntNoArgLabel(_: CInt, _: CInt) -> CInt {
  print("passTwoIntReturnIntNoArgLabel")
  return 42
}

// CHECK: inline int passTwoIntReturnIntNoArgLabel(int _1, int _2) noexcept SWIFT_WARN_UNUSED_RESULT {
// CHECK: return _impl::$s9Functions016passTwoIntReturnD10NoArgLabelys5Int32VAD_ADtF(_1, _2);
// CHECK: }

public func passTwoIntReturnIntNoArgLabelParamName(_ x2: CInt, _ y2: CInt) -> CInt { return x2 + y2 }

// CHECK: inline int passTwoIntReturnIntNoArgLabelParamName(int x2, int y2) noexcept SWIFT_WARN_UNUSED_RESULT {
// CHECK:   return _impl::$s9Functions016passTwoIntReturnD19NoArgLabelParamNameys5Int32VAD_ADtF(x2, y2);
// CHECK: }

public func passVoidReturnVoid() { print("passVoidReturnVoid") }

// CHECK: inline void passVoidReturnVoid(void) noexcept {
// CHECK: return _impl::$s9Functions014passVoidReturnC0yyF();
// CHECK: }

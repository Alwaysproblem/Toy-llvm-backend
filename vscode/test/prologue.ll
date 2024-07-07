target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

; Function Attrs: noinline nounwind optnone
define dso_local void @foo() #0 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 1, ptr %x, align 4
  %0 = load i32, ptr %x, align 4
  store i32 %0, ptr %y, align 4
  %1 = load i32, ptr %y, align 4
  store i32 %1, ptr %z, align 4
  ret void
}
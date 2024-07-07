target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

; Function Attrs: noinline nounwind optnone
define dso_local i32 @foo() #0 {
  %a = alloca i32, align 4
  store i32 10, ptr %a, align 4
  %1 = load i32, ptr %a, align 4
  %add = add nsw i32 %1, 10
  ret i32 %add
}

target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

define i32 @main(){
  %c = alloca i32, align 4
  %1 = load i32, ptr %c, align 4
  ret i32 %1
}

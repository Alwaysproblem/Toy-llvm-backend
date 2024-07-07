; target datalayout = "e-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S128"
target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
; target datalayout = "E-m:e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-a:8:16-n32"
target triple = "toy"

define i32 @main(i32 %a){
  %b = add i32 %a, 10
  %c = add i32 %b, 9
  %res = add i32 %c, 8
  ret i32 %res
}

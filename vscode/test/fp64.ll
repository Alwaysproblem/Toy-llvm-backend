; target datalayout = "e-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S128"
target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
; target datalayout = "E-m:e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-a:8:16-n32"
target triple = "toy"

define double @main(double %a, double %b){
  %res = fdiv double %a, %b
  %c = fdiv double %a, %res
  %d = fdiv double %a, %c
  ret double %d
}

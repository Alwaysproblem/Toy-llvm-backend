; target datalayout = "e-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S128"
target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
; target datalayout = "E-m:e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-a:8:16-n32"
target triple = "toy"

define float @main(float %a, float %b){
  %res = fdiv float %a, %b
  %c = fdiv float %a, %res
  %d = fdiv float %a, %c
  ret float %d
}

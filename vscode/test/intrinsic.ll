target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

@.str = private unnamed_addr constant [4 x i8] c"%p\0A\00", align 1

; Declare the toy_getsp intrinsic function
declare ptr @llvm.toy.getsp() #1

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main() #0 {
entry:
  ; Call llvm.toy.getsp intrinsic function
  %sp = call ptr @llvm.toy.getsp()
  
  ; Print the stack pointer
  %0 = call i32 (ptr, ...) @printf(ptr @.str, ptr %sp)
  
  ; Return 0
  ret i32 0
}

declare i32 @printf(ptr, ...) #1

attributes #0 = { noinline nounwind optnone }
attributes #1 = { nounwind }

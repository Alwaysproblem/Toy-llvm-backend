target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-n32-S128"
target triple = "toy"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Declare the toy_mod intrinsic function
declare i32 @llvm.toy.mod(i32, i32) #1

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main() #0 {
entry:
  ; Define two integer values
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 10, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %0 = load i32, ptr %a, align 4
  %1 = load i32, ptr %b, align 4
  
  ; Call llvm.toy.mod intrinsic function
  %mod = call i32 @llvm.toy.mod(i32 %0, i32 %1)
  
  ; Print the modulus result
  %2 = call i32 (ptr, ...) @printf(ptr @.str, i32 %mod)

  ret i32 0
}

declare i32 @printf(ptr, ...) #1

attributes #0 = { noinline nounwind optnone }
attributes #1 = { nounwind }
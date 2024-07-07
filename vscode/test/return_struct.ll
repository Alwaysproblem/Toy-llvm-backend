target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

%struct.X = type { i32, i32, i32, i32 }

; Function Attrs: noinline nounwind optnone
define dso_local [2 x i64] @foo() #0 {
entry:
  %retval = alloca %struct.X, align 4
  %a0 = getelementptr inbounds %struct.X, ptr %retval, i32 0, i32 0
  store i32 1, ptr %a0, align 4
  %a1 = getelementptr inbounds %struct.X, ptr %retval, i32 0, i32 1
  store i32 2, ptr %a1, align 4
  %a7 = getelementptr inbounds %struct.X, ptr %retval, i32 0, i32 3
  store i32 3, ptr %a7, align 4
  %0 = load [2 x i64], ptr %retval, align 4
  ret [2 x i64] %0
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %x = alloca %struct.X, align 4
  store i32 0, ptr %retval, align 4
  %call = call [2 x i64] @foo()
  store [2 x i64] %call, ptr %x, align 4
  ret i32 0
}

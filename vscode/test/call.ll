target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

; Function Attrs: noinline nounwind optnone
define dso_local void @foo() #0 {
  %a = alloca i32, align 4
  store i32 10, ptr %a, align 4
  %1 = load i32, ptr %a, align 4
  %add = add nsw i32 %1, 10
  store i32 %add, ptr %a, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 4
  store i32 0, ptr %retval, align 4
  store i32 %argc, ptr %argc.addr, align 4
  store ptr %argv, ptr %argv.addr, align 4
  call void @foo()
  ret i32 0
}

target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @foo(i32 noundef signext %a, i32 noundef signext %b, i32 noundef signext %c, i32 noundef signext %d) #0 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c.addr = alloca i32, align 4
  %d.addr = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  store i32 %c, ptr %c.addr, align 4
  store i32 %d, ptr %d.addr, align 4
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %mul = mul nsw i32 %0, %1
  %2 = load i32, ptr %c.addr, align 4
  %add = add nsw i32 %mul, %2
  %3 = load i32, ptr %d.addr, align 4
  %add1 = add nsw i32 %add, %3
  ret i32 %add1
}

declare i32 @printf(ptr, ...) #1

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  store i32 5, ptr %d, align 4
  %0 = load i32, ptr %a, align 4
  %1 = load i32, ptr %b, align 4
  %2 = load i32, ptr %c, align 4
  %3 = load i32, ptr %d, align 4
  %call = call signext i32 @foo(i32 noundef signext %0, i32 noundef signext %1, i32 noundef signext %2, i32 noundef signext %3)
  store i32 %call, ptr %e, align 4
  %4 = load i32, ptr %e, align 4
  %5 = call i32 (ptr, ...) @printf(ptr @.str, i32 %4)
  ret i32 %4
}

attributes #0 = { noinline nounwind optnone }
attributes #1 = { nounwind }
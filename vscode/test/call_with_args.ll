target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @foo(i32 noundef signext %a, i32 noundef signext %b) #0 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  store i32 %b, ptr %b.addr, align 4
  %0 = load i32, ptr %a.addr, align 4
  %1 = load i32, ptr %b.addr, align 4
  %mul = mul nsw i32 %0, %1
  %2 = load i32, ptr %a.addr, align 4
  %add = add nsw i32 %mul, %2
  %3 = load i32, ptr %b.addr, align 4
  %add1 = add nsw i32 %add, %3
  ret i32 %add1
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 3, ptr %a, align 4
  store i32 1, ptr %b, align 4
  %0 = load i32, ptr %a, align 4
  %1 = load i32, ptr %b, align 4
  %call = call signext i32 @foo(i32 noundef signext %0, i32 noundef signext %1)
  store i32 %call, ptr %c, align 4
  %2 = load i32, ptr %c, align 4
  ret i32 %2
}

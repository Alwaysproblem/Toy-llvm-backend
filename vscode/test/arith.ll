; ModuleID = '/root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/.vscode/test/arith.bc'
source_filename = "/root/Desktop/dockerVolumn/Toy-llvm-backend/llvm-project/llvm/../../examples/arith.c"
target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

; Function Attrs: noinline nounwind optnone
define dso_local void @foo() #0 {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %f = alloca i32, align 4
  %g = alloca i32, align 4
  %h = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 10, ptr %a, align 4
  %0 = load i32, ptr %a, align 4
  %add = add nsw i32 %0, 10
  store i32 %add, ptr %b, align 4
  %1 = load i32, ptr %a, align 4
  %sub = sub nsw i32 %1, 1
  store i32 %sub, ptr %c, align 4
  %2 = load i32, ptr %b, align 4
  %3 = load i32, ptr %c, align 4
  %add1 = add nsw i32 %2, %3
  store i32 %add1, ptr %d, align 4
  %4 = load i32, ptr %b, align 4
  %5 = load i32, ptr %c, align 4
  %mul = mul nsw i32 %4, %5
  store i32 %mul, ptr %e, align 4
  %6 = load i32, ptr %b, align 4
  %7 = load i32, ptr %c, align 4
  %div = sdiv i32 %6, %7
  store i32 %div, ptr %f, align 4
  %8 = load i32, ptr %b, align 4
  %9 = load i32, ptr %c, align 4
  %rem = srem i32 %8, %9
  store i32 %rem, ptr %g, align 4
  %10 = load i32, ptr %b, align 4
  %and = and i32 %10, 1
  store i32 %and, ptr %h, align 4
  %11 = load i32, ptr %b, align 4
  %or = or i32 %11, 1
  store i32 %or, ptr %i, align 4
  %12 = load i32, ptr %b, align 4
  %13 = load i32, ptr %c, align 4
  %and2 = and i32 %12, %13
  %14 = load i32, ptr %d, align 4
  %and3 = and i32 %and2, %14
  store i32 %and3, ptr %j, align 4
  %15 = load i32, ptr %b, align 4
  %16 = load i32, ptr %c, align 4
  %or4 = or i32 %15, %16
  %or5 = or i32 %or4, 1
  store i32 %or5, ptr %k, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 4
  store i32 0, ptr %retval, align 4
  store i32 %argc, ptr %argc.addr, align 4
  store ptr %argv, ptr %argv.addr, align 4
  call void @foo()
  ret i32 0
}

attributes #0 = { noinline nounwind optnone "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cpu-rv32" "target-features"="+32bit,+a,+d,+f,+m,+relax,-c,-e,-experimental-zawrs,-experimental-zca,-experimental-zcd,-experimental-zcf,-experimental-zihintntl,-experimental-ztso,-experimental-zvfh,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xtheadvdot,-xventanacondops,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zihintpause,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32d"}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{!"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"}

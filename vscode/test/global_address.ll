target datalayout = "e-m:e-p:32:32:32-i8:8:32-i16:16:32-i64:64-f32:32:32-f64:64:64-a:8:16-n32-S128"
target triple = "toy"

@intGlobal = global i32 10

define void @useGlobals() {
    ; 读取全局变量 intGlobal 的值
    %intVal = load i32, i32* @intGlobal
    ; 修改 intGlobal 的值
    store i32 20, i32* @intGlobal
    ret void
}
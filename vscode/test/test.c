int foo(int a, int b) {
    return a * b + a + b;
}

int main(){
    int a = 3, b = 1;
    int c = foo(a, b);
    return c;
}
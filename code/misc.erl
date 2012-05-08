-module(misc).
-compile(export_all).

perimeter({square, X})            -> 4 * X;
perimeter({rectangle, Width, Ht}) -> 2 * (Width+Ht);
perimeter({circle, R})            -> 2 * math:pi() * R;
perimeter({triangle, A, B, C})    -> A + B + C.



fac2(0) -> 1;
fac2(N) when is_integer(N), N > 0 -> N * fac2(N-1);
fac2(N) when is_integer(N), N < 0 -> exit({factorialNegativeArgument, N});
fac2(X) -> exit({factorialArgumentNotAnInteger, X}).



fac1(0) -> 1;
fac1(N) when N > 0 -> N * fac1(N-1).


    
    

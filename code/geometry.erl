-module(geometry).  
-export([area/1]). 

area({rectangle, Width, Height}) -> Width * Height;
area({circle, R})                -> 3.14159 * R * R.


     


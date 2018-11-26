
# ieee754-packing

When it comes to serializing `float` and `double` in C/C++, the accepted wisdom is to stream them as text, or use some sort of library. I always thought this is unsatisfactory. Text can take up a lot of space, and it is sometimes impractical to use libraries. Besides, why the code bloat, when all you want to do is serialize some numbers!

The code in `ieee-packing.hpp` serializes single and double precision floating point numbers using _only well definied C++_ features. As such, it should work on any hardware that supports 64bit integers. It is only as accurate as the standard library routines `std::frexp` and `std::ldexp`, and thus cannot be expected to be more accurate than `std::numeric_limits<T>::epsilon()`. However, it does work with denormalized (i.e., very very tiny) numbers.

ieee754 uses 8 and 11 bits for the exponents of (respectively) floats and doubles. If your hardware does not use this many bits in its representation, then there will be a further loss of precision. This will be indicated by a failure in one of the test cases.

*Note* the packed result is an unsigned integer in the _byte order of your platform_. Thus, when swapping numbers between little endian and big endian systems, it is imperative to fix the byte order. For example, use the macros in `<endian.h>`.

## testing

```
make test
./test
```

## example

```
#include <iostream>
#include "ieee-packing.hpp"

int main(int, char**)
{
   double value  = M_PI;
   auto packed   = pack_f64(value);
   auto unpacked = unpack_f64(packed);

   printf("   Number is:      %f\n", value);
   printf("   Number (hex):   %a\n", value);
   printf("   Packed value:   0x%016lx\n", packed);
   printf("   Unpacked (hex): %a\n", unpacked);
   printf("   Error:          %a\n", fabs(value - unpacked)); // 0.0
}
```

Output is:

```
   Number is:      3.141593
   Number (hex):   0x1.921fb54442d18p+1
   Packed value:   0x400921fb54442d18
   Unpacked (hex): 0x1.921fb54442d18p+1
   Error:          0x0p+0
```

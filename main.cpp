
#include <iostream>

#include "ieee-packing.hpp"

int main(int, char**)
{
   //
   std::cout << "\nieee754 float packing example!\n\n";

   double value  = M_PI;
   auto packed   = pack_f64(value);
   auto unpacked = unpack_f64(packed);

   printf("   Number is:      %f\n", value);
   printf("   Number (hex):   %a\n", value);
   printf("   Packed value:   0x%016lx\n", packed);
   printf("   Unpacked (hex): %a\n", unpacked);
   printf("   Error:          %a\n", fabs(value - unpacked));

   std::cout << "\n"
             << "   Packing and unpacking worked with denomralized \n"
             << "   numbers; however, it is also limited by the \n"
             << "   precision of std::frexp and std::ldexp.\n"
             << "   Therefore, do NOT expect precision better than\n"
             << "   std::numeric_limits<T>::epsilon().\n"
             << "\n";

   return EXIT_SUCCESS;
}

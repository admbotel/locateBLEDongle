//
//  main.cpp
//  locateBluetoothLowEnergyDongle
//
//  Created by Aaron Botelho on 2013-06-19.
//  Copyright (c) 2013 Thalmic Labs. All rights reserved.
//

#include <iostream>
#import "USBUtils.h"
#include <MacTypes.h>

int main(int argc, const char * argv[])
{
  SInt32 usbVendor = kOurVendorID;
  SInt32 usbProduct = kOurProductID;

  // insert code here...
  std::cout << "Hello, World!\n";
  
  if (argc > 1)
    usbVendor = atoi(argv[1]);
  if (argc > 2)
    usbProduct = atoi(argv[2]);
  
  USBUtils* utils = [USBUtils alloc]init];
  
    return 0;
}


//
//  USBUtils.h
//  locateBLEDongle
//
//  Created by Aaron Botelho on 2013-06-19.
//  Copyright (c) 2013 Thalmic Labs. All rights reserved.
//


#import <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>
#include <IOKit/usb/USBSpec.h>
#include <stdlib.h>
#include <string.h>

class ThalmicUSBDeviceInfo{
  
public:
  std::string vendorId;
  std::string productID;
}


public class USBUtils{
  
public:
  void findDongleWithVenID(int vID, int pID);
}

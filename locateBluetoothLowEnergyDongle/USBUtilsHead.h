//
//  USBUtilsHead.h
//  locateBLEDongle
//
//  Created by Aaron Botelho on 2013-06-25.
//  Copyright (c) 2013 Thalmic Labs. All rights reserved.
//

#ifndef locateBLEDongle_USBUtilsHead_h
#define locateBLEDongle_USBUtilsHead_h


#import <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>
#include <IOKit/usb/USBSpec.h>
#include <stdlib.h>
#include <string.h>

class ThalmicUSBDeviceInfo{
  
private:
  std::string _vendorID;
  std::string _productID;
  
public:
  std::string getVendorID();
  setVendorID(std::string vID);
  
  std::string getProductID();
  setProductID(std::string pID);
}


public class USBUtils{
  
public:
  void findDongleWithVenID(int vID, int pID);
}


#endif

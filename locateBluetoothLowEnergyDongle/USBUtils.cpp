//
//  USBUtils.cpp
//  locateBLEDongle
//
//  Created by Aaron Botelho on 2013-06-25.
//  Copyright (c) 2013 Thalmic Labs. All rights reserved.
//

#include "USBUtilsHead.h"

std::string USBUtils::getVendorID()
{
  return _vendorID;
}

USBUtils::setVendorID(std::string vID)
{
  _vendorID = vID;
}

std::string USBUtils::getProductID()
{
  return _productID;
}

USBUtils::setProductID(std::string pID)
{
  _productID = pID;
}

public class USBUtils{
  
public:
  void findDongleWithVenID(int vID, int pID);
}

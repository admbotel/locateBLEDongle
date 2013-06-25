//
//  USBUtils.m
//  locateBLEDongle
//
//  Created by Aaron Botelho on 2013-06-19.
//  Copyright (c) 2013 Thalmic Labs. All rights reserved.
//

#import "USBUtils.h"
#include <stdlib.h>

const char* kIOUSBDeviceKey = "IOUSBDevice";

@implementation ThalmicUSBDeviceInfo

-(id)init{
  
  self = [super init];
  
  if(self){
    self.productId = nil;
    self.vendorId = nil;
  }
  
  return self;
}
@end


@implementation USBUtils

-(id)init{
  self = [super init];
  return self;
}

-(void)findDongleWithVenID:(int)inVendorID andProductId:(int)inProductID{
  
  ThalmicUSBDeviceInfo* info = [[ThalmicUSBDeviceInfo alloc]init];
  
  CFMutableDictionaryRef matchingDict;
	matchingDict = IOServiceMatching(kIOUSBDeviceKey);
  
	CFNumberRef pVendorID = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &inVendorID);
  CFDictionarySetValue(matchingDict, CFSTR(kUSBVendorID), pVendorID);
  CFRelease(pVendorID);
  
	CFNumberRef pProductID = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &inProductID);
  CFDictionarySetValue(matchingDict, CFSTR(kUSBProductID), pProductID);
  CFRelease(pProductID);
  
  if (matchingDict)
	{
		io_iterator_t iterator;
    io_service_t usbDevice;
		if (KERN_SUCCESS == IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &iterator))
		{
			while ((usbDevice = IOIteratorNext(iterator)))
			{
        
        // you could also do this check by the device's class name:
        io_name_t className;
        IOObjectGetClass( usbDevice, className );
        // fprintf( stderr, "This device's className is %s\n",
        //          (const char*)className );
        if ( strcmp( className, "IOUSBDevice" )) continue;
        else NSLog(@"%@", @"Reference was not of type IOUSBDevice");
        
        [self getUSBDevice:usbDevice withInfo:info];
        IOObjectRelease(usbDevice);
			}
      
			IOObjectRelease(iterator);
		}
	}
}

-(void)getUSBDevice:(io_service_t) usbDevice withInfo:(ThalmicUSBDeviceInfo*) info{
  SInt32                        score;
  IOCFPlugInInterface**         plugin;
  IOUSBDeviceInterface**     usbDeviceInterface = NULL;
  kern_return_t err;
  
  err = IOCreatePlugInInterfaceForService( usbDevice,
                                          kIOUSBDeviceUserClientTypeID,
                                          kIOCFPlugInInterfaceID,
                                          &plugin,
                                          &score );
  if ( err != 0 )
  {
    // error getting the plugin interface. You can get this if you somehow
    // found your way here before the device and volumes are fully mounted.
    return;
  }
  
  // Now get the USB device interface. This will allow you to make the low-level
  // USB bus calls to extract device information. This is just a wrapper to
  // the low level USB interface. Once you have one of these, you can manipulate
  // the device at the bus level. BTW "182" means the version of this function.
  // OsX will keep updating this function as their support for new USB bus
  // features is implemented. For our purposes we need 182 or higher.
  err = (*plugin)->QueryInterface(
                                  plugin,
                                  CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID182),
                                  (void**)&usbDeviceInterface );
  
  // we just needed the plugin interface to get the USB interface, so we can
  // release it now.
  IODestroyPlugInInterface( plugin );
  
  if ( err != 0 )
  {
    // failed to get the bus interface.
    NSLog(@"%@", @"Failed to get the USB bus interface.");
    return;
  }
  
  UInt16 VID;
  UInt16 PID;
  
  if(!(*usbDeviceInterface)->GetDeviceVendor( usbDeviceInterface, &VID ) == kIOReturnSuccess){
    NSLog(@"%@", @"Could not find the device vendor ID");
  }else{
    NSLog(@"VID is equal to: %d",VID);
    info.vendorId = [NSString stringWithFormat:@"%d",VID];
  }
  if(!(*usbDeviceInterface)->GetDeviceProduct( usbDeviceInterface, &PID ) == kIOReturnSuccess){
    NSLog(@"%@", @"Could not find the device product ID");
  }else{
    NSLog(@"PID is equal to: %d",PID);
    info.vendorId = [NSString stringWithFormat:@"%d",PID];
  }
}

@end

static const UInt8 kKeychainItemIdentifier[] = "com.TestApp1.KeychainUI";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{  
  NSData* keychainItemID = [NSData dataWithBytes:kKeychainItemIdentifier length:strlen((const char*)kKeychainItemIdentifier)];
  
  NSDictionary* searchQuery = [NSDictionary dictionaryWithObjectsAndKeys:
                                (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClass,
                                keychainItemID, (__bridge id)kSecAttrGeneric,
                                kSecMatchLimitOne, (__bridge id)kSecMatchLimit,
                                kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                              nil];
  NSLog(@"Done constructing query. About to launch it.");

  
  OSStatus keychainErr = noErr;
  
  CFDictionaryRef attributesReturned = nil;
  keychainErr = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, (CFTypeRef *) &attributesReturned);
  
  NSLog(@"Sent query. Inspecting result was %ld ", keychainErr);
  if(keychainErr == errSecItemNotFound) {

    NSString* password = @"secrettime";
    
    NSLog(@"Unable to find item.");
    NSDictionary* item = [NSDictionary dictionaryWithObjectsAndKeys:
                          (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClass,
                          keychainItemID, (__bridge id)kSecAttrGeneric,
                          [password dataUsingEncoding:NSUTF8StringEncoding], (__bridge id)kSecValueData,
                          kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                          nil];
    
    CFDictionaryRef itemAddAttributesReturned = nil;
    keychainErr = SecItemAdd((__bridge CFDictionaryRef) item, (CFTypeRef*)&itemAddAttributesReturned);
    if(keychainErr == noErr) {
      NSLog(@"Added keychain. Got back the following: ");
      NSDictionary* dictAttributesReturned = (__bridge_transfer NSDictionary*)itemAddAttributesReturned;
      [dictAttributesReturned enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@ = %@", key, obj);
      }];
    }
    else {
      NSLog(@"Unable to add keychain");
    }
  } else {
    NSLog(@"Found an item.");

    NSMutableDictionary* dataSearchQuery = [searchQuery mutableCopy];
    [dataSearchQuery removeObjectForKey:(__bridge id)kSecReturnAttributes];
    [dataSearchQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFTypeRef dataReturnedRef = nil;
    keychainErr = SecItemCopyMatching((__bridge CFDictionaryRef)dataSearchQuery, &dataReturnedRef);
    NSData* dataReturned = (__bridge NSData*)dataReturnedRef;
    
    if(keychainErr == noErr) {
      NSLog(@"Password is: %@", [[NSString alloc] initWithData:dataReturned encoding:NSUTF8StringEncoding]);
    }
    else {
      NSLog(@"Error while fetching data of the item.");
    }
    
    
    
    
    NSDictionary* dictAttributesReturned = (__bridge_transfer NSDictionary*)attributesReturned;
    [dictAttributesReturned enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      NSLog(@"%@ = %@", key, obj);
    }];
    

    NSLog(@"Going to update the item.");
    NSDictionary* updatableQuery = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (__bridge id)kSecClassGenericPassword, (__bridge id) kSecClass,
                                    keychainItemID, (__bridge id)kSecAttrGeneric,
                                    nil];

    NSDictionary* updatedItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [@"updatedPassword." dataUsingEncoding:NSUTF8StringEncoding], (__bridge id)kSecValueData,
                                 nil];
    
    keychainErr = SecItemUpdate((__bridge CFDictionaryRef) updatableQuery, (__bridge CFDictionaryRef) updatedItem);
    if(keychainErr == noErr) {
      NSLog(@"Update successful.");
    }
    else if(keychainErr == errSecParam) {
      NSLog(@"Update encountered a bad paramter.");
    }
    else {
      NSLog(@"Update failed with result %ld", keychainErr);
    }
    
  }

  NSLog(@"all done.");

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

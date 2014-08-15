//
//  MPServerSettingsController.m
//  MacPass
//
//  Created by Michael Starke on 17.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "MPIntegrationSettingsController.h"
#import "MPSettingsHelper.h"
#import "MPIconHelper.h"

#import "DDHotKeyCenter.h"
#import "DDHotKey+Keydata.h"
#import "DDHotKeyTextField.h"

@interface MPIntegrationSettingsController ()

@property (nonatomic, copy) NSData *globalAutotypeKeyData;

@end

@implementation MPIntegrationSettingsController

- (NSString *)nibName {
  return @"IntegrationSettings";
}

- (NSString *)identifier {
  return @"Integration";
}

- (NSImage *)image {
  return [NSImage imageNamed:NSImageNameComputer];
}

- (NSString *)label {
  return NSLocalizedString(@"INTEGRATION_SETTINGS", "");
}

- (void)awakeFromNib {
  NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
  NSString *serverKeyPath = [MPSettingsHelper defaultControllerPathForKey:kMPSettingsKeyEnableHttpServer];
  NSString *globalAutotypeKeyPath = [MPSettingsHelper defaultControllerPathForKey:kMPSettingsKeyEnableGlobalAutotype];
  NSString *quicklookKeyPath = [MPSettingsHelper defaultControllerPathForKey:kMPSettingsKeyEnableQuicklookPreview];
  NSString *globalAutotypeDataKeyPath = [MPSettingsHelper defaultControllerPathForKey:kMPSettingsKeyGlobalAutotypeKeyDataKey];
  [self.enableServerCheckbutton bind:NSValueBinding toObject:defaultsController withKeyPath:serverKeyPath options:nil];
  [self.enableServerCheckbutton setEnabled:NO];
  [self.enableGlobalAutotypeCheckbutton bind:NSValueBinding toObject:defaultsController withKeyPath:globalAutotypeKeyPath options:nil];
  [self.enableQuicklookCheckbutton bind:NSValueBinding toObject:defaultsController withKeyPath:quicklookKeyPath options:nil];
  [self.globalAutotypeKeyData bind:NSValueBinding toObject:defaultsController withKeyPath:globalAutotypeDataKeyPath options:nil];
}

#pragma mark Properties
- (void)setGlobalAutotypeKeyData:(NSData *)globalAutotypeKeyData {
  if(![_globalAutotypeKeyData isEqualToData:globalAutotypeKeyData]) {
    _globalAutotypeKeyData = [globalAutotypeKeyData copy];
  }
  DDHotKey *hotKey = [[DDHotKey alloc] initWithKeyData:_globalAutotypeKeyData];
  self.hotKeyTextField.hotKey = hotKey;
}


@end
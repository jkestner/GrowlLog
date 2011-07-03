//
//  GrowlLogDisplay.h
//  Growl Display Plugins
//
//  John Kestner/MIT Media Lab, 2009-11
//  Started with code from Ingmar Stein and The Growl Project
//  Released under an MIT license


#import <Cocoa/Cocoa.h>
#import <GrowlDisplayPlugin.h>

@class GrowlApplicationNotification;

@interface GrowlLogDisplay : GrowlDisplayPlugin {
}

//- (void) configureBridge:(GrowlNotificationDisplayBridge *)theBridge;
- (NSString *) xmlFromDictionary:(NSDictionary *)dict;
- (NSString *)publish:(NSString *)string toDirectory:(NSString *)directory;

@end

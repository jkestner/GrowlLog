//
//  GrowlLogPrefs.m
//  Display Plugins
//
//  John Kestner/MIT Media Lab, 2009-11
//  Started with code from Ingmar Stein and The Growl Project
//  Released under an MIT license


#import "GrowlLogPrefs.h"
#import "GrowlDefinesInternal.h"

@implementation GrowlLogPrefs

- (NSString *) mainNibName {
	return @"GrowlLogPrefs";
}

- (void) mainViewDidLoad {
//	[slider_opacity setAltIncrementValue:5.0];
}

- (void) didSelect {
	SYNCHRONIZE_GROWL_PREFS();
}

#pragma mark -

- (NSString *) getFilePath {
	NSString *value = nil;
	READ_GROWL_PREF_VALUE(GrowlLogPathPref, GrowlLogPrefDomain, NSString *, &value);
	if(value)
		CFMakeCollectable(value);
	return [value autorelease];
}

- (void) setFilePath:(NSString *)value {
	if (!value)
		value = @"";
	WRITE_GROWL_PREF_VALUE(GrowlLogPathPref, value, GrowlLogPrefDomain);
	UPDATE_GROWL_PREFS();
}

@end

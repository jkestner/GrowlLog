//
//  GrowlLogDisplay.h
//  Growl Display Plugins
//
//  John Kestner/MIT Media Lab, 2009-11
//  Started with code from Ingmar Stein and The Growl Project
//  Released under an MIT license


#import "GrowlLogDisplay.h"
#import "GrowlLogPrefs.h"
#import "GrowlApplicationNotification.h"
#import <GrowlDefinesInternal.h>
#import <GrowlDefines.h>

@implementation GrowlLogDisplay

- (id) init {
	if ((self = [super init])) {
		windowControllerClass = NSClassFromString(@"GrowlLogWindowController");
	}
	return self;
}

- (void) dealloc {
	[preferencePane release];
	[super dealloc];
}

- (NSPreferencePane *) preferencePane {
	if (!preferencePane)
		preferencePane = [[GrowlLogPrefs alloc] initWithBundle:[NSBundle bundleForClass:[GrowlLogPrefs class]]];
	return preferencePane;
}

#pragma mark -
#pragma mark GrowlPositionController Methods
#pragma mark -

- (void) displayNotification:(GrowlApplicationNotification *)notification {
	
	NSString *path = nil;
	READ_GROWL_PREF_VALUE(GrowlLogPathPref, GrowlLogPrefDomain, NSString *, &path);
	
	NSDictionary *noteDict = [notification dictionaryRepresentation];
	
	if (path && [[path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
		CFMakeCollectable(path);
		[path autorelease];
		[self publish: [self xmlFromDictionary:noteDict] toDirectory:path];
	}
	else {
		NSLog(@"%@",[self xmlFromDictionary:noteDict]);
	}
	
}

- (BOOL)requiresPositioning {
	return NO;
}

#pragma mark -
#pragma mark GAB
#pragma	mark -

- (NSString *) xmlFromDictionary:(NSDictionary *)dict 
{
    // cobble together the XML - not worth a fancier method
    
	NSString *xml = [NSString string];
	xml = [xml stringByAppendingString:@"<notification>\n"];
	
	xml = [xml stringByAppendingFormat:@"\t<id>%@</id>\n",[dict objectForKey:GROWL_NOTIFICATION_IDENTIFIER]];
	xml = [xml stringByAppendingFormat:@"\t<name>%@</name>\n",[dict objectForKey:GROWL_NOTIFICATION_NAME]];
	xml = [xml stringByAppendingFormat:@"\t<title>%@</title>\n",[dict objectForKey:GROWL_NOTIFICATION_TITLE]];
	xml = [xml stringByAppendingFormat:@"\t<description>%@</description>\n",[dict objectForKey:GROWL_NOTIFICATION_DESCRIPTION]];
	xml = [xml stringByAppendingFormat:@"\t<priority>%@</priority>\n",[dict objectForKey:GROWL_NOTIFICATION_PRIORITY]];
	
	xml = [xml stringByAppendingFormat:@"\t<url>%@</url>\n",[dict objectForKey:GROWL_NOTIFICATION_CLICK_CONTEXT]];
    xml = [xml stringByAppendingFormat:@"keys: %@",[dict allKeys]];
    xml = [xml stringByAppendingFormat:@"obj: %@", NSStringFromClass([[dict objectForKey:GROWL_NOTIFICATION_CLICK_CONTEXT] class])];

	xml = [xml stringByAppendingFormat:@"\t<application>%@</application>\n",[dict objectForKey:GROWL_APP_NAME]];
	xml = [xml stringByAppendingFormat:@"\t<pid>%@</pid>\n",[dict objectForKey:GROWL_APP_PID]];
	xml = [xml stringByAppendingFormat:@"\t<timestamp>%@</timestamp>\n",[NSDate date]];
	
	xml = [xml stringByAppendingString:@"</notification>\n"];
	
	return xml;
}

- (NSString *)publish:(NSString *)string toDirectory:(NSString *)directory
{
	NSString *path = [[directory stringByStandardizingPath] stringByExpandingTildeInPath];

	// if supplied string doesn't end with .xml, assume it's a directory and not a file
	if (![[path pathExtension] isEqualToString:@"xml"]) {
		NSString *fileName = @"GrowlLog.xml";
		NSString *folderPath = [path stringByAppendingString:@"/"];
		
		// create folder to hold file
		[[NSFileManager defaultManager] createDirectoryAtPath:folderPath attributes:nil];
		
		path = [path stringByAppendingPathComponent: fileName];
		//	[notifications writeToFile:path atomically:YES encoding:NSUnicodeStringEncoding error:nil];
	}
	
	// write file
	NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath: path];
	if (fileHandle == nil) {
		// create and write to file if it doesn't exist
		string = [@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" stringByAppendingString: string];
		[string writeToFile:path atomically:YES encoding: NSUTF8StringEncoding error:nil];
	}
	else {
		//	I think you can use NSFileManager method
		//	- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)contents attributes:(NSDictionary *)attributes
		
		[fileHandle truncateFileAtOffset:[fileHandle seekToEndOfFile]]; // write at the end of the file
		[fileHandle writeData: [string dataUsingEncoding: NSUTF8StringEncoding]];
	}
	return [path stringByDeletingLastPathComponent];
    
}

//- (void) configureBridge:(GrowlNotificationDisplayBridge *)theBridge {
//	GrowlLogWindowController *controller = [[theBridge windowControllers] objectAtIndex:0U];
//	GrowlApplicationNotification *note = [theBridge notification];
//	NSDictionary *noteDict = [note dictionaryRepresentation];
//	
//	[controller setNotifyingApplicationName:[note applicationName]];
//	[controller setNotifyingApplicationProcessIdentifier:[noteDict objectForKey:GROWL_APP_PID]];
//	[controller setClickContext:[noteDict objectForKey:GROWL_NOTIFICATION_CLICK_CONTEXT]];
//	[controller setScreenshotModeEnabled:getBooleanForKey(noteDict, GROWL_SCREENSHOT_MODE)];
//	[controller setClickHandlerEnabled:[noteDict objectForKey:@"ClickHandlerEnabled"]];
//	
//}

@end

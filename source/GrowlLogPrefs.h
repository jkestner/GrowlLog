//
//  GrowlLogPrefs.h
//  Display Plugins
//
//  John Kestner/MIT Media Lab, 2009-11
//  Started with code from Ingmar Stein and The Growl Project
//  Released under an MIT license


#import <PreferencePanes/PreferencePanes.h>

#define GrowlLogPrefDomain			@"com.Growl.Log"
#define GrowlLogPathPref	@"Log - Path"

//#define Sample_SCREEN_PREF			@"Screen"
//
//#define Sample_OPACITY_PREF			@"Opacity"
//#define Sample_DEFAULT_OPACITY		60.0f
//
//#define Sample_DURATION_PREF		@"Duration"
//#define Sample_DEFAULT_DURATION		4.0f
//
//#define Sample_SIZE_PREF			@"Size"
//#define Sample_SIZE_NORMAL			0
//#define Sample_SIZE_HUGE			1
//
//#define Sample_EFFECT_PREF			@"Transition effect"
//
//typedef enum 
//{
//	Sample_EFFECT_SLIDE = 0
//} SampleEffectType;
//
//#define GrowlLogVeryLowBackgroundColor	@"Sample-Priority-VeryLow-Color"
//#define GrowlLogModerateBackgroundColor	@"Sample-Priority-Moderate-Color"
//#define GrowlLogNormalBackgroundColor	@"Sample-Priority-Normal-Color"
//#define GrowlLogHighBackgroundColor		@"Sample-Priority-High-Color"
//#define GrowlLogEmergencyBackgroundColor	@"Sample-Priority-Emergency-Color"
//
//#define GrowlLogVeryLowTextColor			@"Sample-Priority-VeryLow-Text-Color"
//#define GrowlLogModerateTextColor		@"Sample-Priority-Moderate-Text-Color"
//#define GrowlLogNormalTextColor			@"Sample-Priority-Normal-Text-Color"
//#define GrowlLogHighTextColor			@"Sample-Priority-High-Text-Color"
//#define GrowlLogEmergencyTextColor		@"Sample-Priority-Emergency-Text-Color"

@interface GrowlLogPrefs : NSPreferencePane {
//	IBOutlet NSSlider *slider_opacity;
}

- (NSString *) getFilePath;
- (void) setFilePath:(NSString *)value;

@end

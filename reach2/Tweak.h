@import Foundation;
@import UIKit;

#define reachPath @"/Library/Application Support/reach.bundle"
#import <SpringBoardServices/SBSRelaunchAction.h>



@interface FBSSystemService : NSObject
+ (instancetype)sharedService;
- (void)sendActions:(NSSet *)actions withResult:(id)result;
@end

@interface NSUserDefaults (tweakname)
-(id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
-(void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString *nsDomainString = @"/var/mobile/Library/Preferences/im.clu3less.reachprefs.plist";
static NSString *nsNotificationString = @"im.clu3less.reachprefs-prefsreload";


static BOOL tweakEnabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    NSNumber *eTweakEnabled = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"isTweakEnabled" inDomain:nsDomainString];


    tweakEnabled = (eTweakEnabled) ? [eTweakEnabled boolValue]:YES;  
}




//////////////////////////////

@interface SBReachabilityWindow : UIWindow
@property (nonatomic, retain) UIView *respringView;
@property (nonatomic, retain) UIImageView *respringImageView;
-(void)setupRespringView;
-(void)respringTapped;
@end

@interface SBReachabilityManager : NSObject
+(id)sharedInstance;
@end



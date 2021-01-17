#import "Tweak.h"

%hook SBReachabilityManager
-(void)_setKeepAliveTimer{}
-(void)_tapToDeactivateReachability:(id)arg1 {}
-(void)deactivateReachability{}
%end



%hook SBReachabilityWindow
%property (nonatomic, retain) UIView *respringView;
%property (nonatomic, retain) UIImageView *respringImageView;

-(id)initWithWallpaperVariant:(long long)arg1 {
    self = %orig;
    if(tweakEnabled){
        [self setupRespringView];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if( CGRectContainsPoint(self.respringView.frame, point)){
        [self respringTapped];


    }
    return %orig;
    
}


%new
-(void)setupRespringView{

    CGRect screenRect = [[UIScreen mainScreen] bounds];
   NSBundle *bundle = [[NSBundle alloc] initWithPath:reachPath];
   NSString *imagePath = [bundle pathForResource:@"respring" ofType:@"png"];

    self.respringView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/11, screenRect.size.height/-3, 50, 50)];
    self.respringView.userInteractionEnabled = YES;   
    self.respringView.layer.cornerRadius = 25;
    self.respringView.layer.masksToBounds = true;
    

    UIImage *respringImage = [UIImage imageWithContentsOfFile:imagePath];
    self.respringImageView = [[UIImageView alloc] initWithImage:respringImage];
    self.respringView.backgroundColor = [UIColor blackColor];

    //self.respringImageView.frame = self.respringView.bounds;
    self.respringImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.respringImageView.frame = CGRectMake(0,0, 20, 20);
    self.respringImageView.center = CGPointMake((self.respringView.frame.size.width / 2), (self.respringView.frame.size.height / 2));


    [self.respringView addSubview:self.respringImageView];


    [self addSubview:self.respringView];     

  
  
}

%new
-(void)respringTapped {

    [UIView animateWithDuration:1 delay:0.0f options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.respringImageView.transform = CGAffineTransformMakeRotation(M_PI);
        //self.customReachabilityView.backgroundColor = color;
    } completion:^(BOOL finished){
        if (finished) {
            NSURL *relaunchURL = nil; // use a nil relaunch URL to return to the lock screen
            SBSRelaunchAction *restartAction = [%c(SBSRelaunchAction) actionWithReason:@"RestartRenderServer" options:SBSRelaunchActionOptionsFadeToBlackTransition targetURL:relaunchURL];
            [[%c(FBSSystemService) sharedService] sendActions:[NSSet setWithObject:restartAction] withResult:nil];

        }

    
    }];

}



%end




















//prefs shit
%ctor {
  notificationCallback(NULL, NULL, NULL, NULL, NULL);
 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
    NULL,
    notificationCallback,
    (CFStringRef)nsNotificationString,
    NULL,
    CFNotificationSuspensionBehaviorCoalesce);
  } 
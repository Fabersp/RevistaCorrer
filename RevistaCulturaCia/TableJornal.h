

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
@import GoogleMobileAds;


@interface TableJornal : UITableViewController <MWPhotoBrowserDelegate, MFMailComposeViewControllerDelegate> {
    NSMutableArray *_selections;
    
    NSArray * news;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    
}
@property (nonatomic, retain) NSDictionary * ObjetoJson;
@property (strong, nonatomic) NSMutableArray *pageImages;
@property (strong, nonatomic) NSString * pastaEdicao;

@property (nonatomic, strong) NSMutableArray *photos;


@property (weak, nonatomic) IBOutlet GADBannerView *ViewBanner;



@end

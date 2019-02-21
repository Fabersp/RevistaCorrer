//
//  TableEdicoes.h
//  RevistaCulturaCia
//
//  Created by Fabricio Padua on 21/05/16.
//  Copyright © 2016 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
@import GoogleMobileAds;


@interface TableEdicoes : UITableViewController <MWPhotoBrowserDelegate, MFMailComposeViewControllerDelegate> {
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

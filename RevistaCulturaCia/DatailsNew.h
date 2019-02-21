//
//  DatailsNew.h
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 06/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"


@interface DatailsNew : UIViewController <UIPageViewControllerDataSource> {
    
    NSDictionary * ObjetoJson;
}



@property (strong, nonatomic) NSMutableArray *pageImages;
@property (strong, nonatomic) NSString * pastaEdicao;
@property (nonatomic, retain) NSDictionary * ObjetoJson;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pages;

- (IBAction)startWalkthrough:(id)sender;



@end

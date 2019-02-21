//
//  CellNews.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 29/04/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "CellNews.h"


@implementation CellNews

@synthesize lbTitulo;
@synthesize lbDetalhe;
@synthesize lbTumbImage;
@synthesize lbTime;
@synthesize btnDownload;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    UIColor *CorVerde = [UIColor colorWithRed:233/255.0 green:137/255.0 blue:70/255.0 alpha:1];
    
    [btnDownload setBackgroundColor:CorVerde];
    btnDownload.layer.cornerRadius = 6.0f;
    btnDownload.layer.masksToBounds = YES;
    
    
}



@end

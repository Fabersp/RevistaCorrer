//
//  ViewContato.h
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>


@interface ViewContatoCliente : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *ViewApper;

@property (weak, nonatomic) IBOutlet UIButton *btnSugestao;

@property (weak, nonatomic) IBOutlet UIButton *btnInformacoes;

@property (weak, nonatomic) IBOutlet UIButton *btnMarketing;

@property (weak, nonatomic) IBOutlet UIButton *btnComercial;

@property (weak, nonatomic) IBOutlet UIButton *btnEventos;
@property (weak, nonatomic) IBOutlet UIButton *btnTelefone;


@property (weak, nonatomic) IBOutlet UIButton *site;

@end

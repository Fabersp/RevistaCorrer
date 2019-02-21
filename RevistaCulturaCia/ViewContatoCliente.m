//
//  ViewContato.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "ViewContatoCliente.h"




@interface ViewContatoCliente ()

@end

@implementation ViewContatoCliente

@synthesize btnEventos;
@synthesize btnSugestao;
@synthesize btnComercial;

@synthesize btnMarketing;
@synthesize btnInformacoes;
@synthesize site;
@synthesize btnTelefone;

@synthesize ViewApper;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Configure the view for the selected state
  /*  UIColor *Laranja = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:34/255.0 alpha:1];
    
    
    
    btnSugestao.layer.cornerRadius = 7.0f;
    btnSugestao.layer.masksToBounds = YES;
    [btnSugestao setBackgroundColor:Laranja];
    
    
    btnInformacoes.layer.cornerRadius = 7.0f;
    btnInformacoes.layer.masksToBounds = YES;
    [btnInformacoes setBackgroundColor:Laranja];

    btnMarketing.layer.cornerRadius = 7.0f;
    btnMarketing.layer.masksToBounds = YES;
    [btnMarketing setBackgroundColor:Laranja];
    
    btnComercial.layer.cornerRadius = 7.0f;
    btnComercial.layer.masksToBounds = YES;
    [btnComercial setBackgroundColor:Laranja];
    
    btnEventos.layer.cornerRadius = 7.0f;
    btnEventos.layer.masksToBounds = YES;
    [btnEventos setBackgroundColor:Laranja];

    btnTelefone.layer.cornerRadius = 7.0f;
    btnTelefone.layer.masksToBounds = YES;
    [btnTelefone setBackgroundColor:Laranja];

    site.layer.cornerRadius = 7.0f;
    site.layer.masksToBounds = YES;
    [site setBackgroundColor:Laranja];
    */
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btnInfo:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController * mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - App  - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"ecoturismo@revistaecoturismo.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else {
        
        [self MessagemAlerta];
        
    }
}

- (IBAction)btnSugestao:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController * mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"sugestão de novas corridas"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"corridas@revistacorrer.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else {
        
        [self MessagemAlerta];
        
    }

}

- (IBAction)btnMarketing:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController * mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - App Ecoturismo - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"marketing@revistaecoturismo.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else {
        
        [self MessagemAlerta];
        
    }

}

- (IBAction)btnComercial:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController * mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - App Correr - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"contato@revistacorrer.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else {
        
        [self MessagemAlerta];
        
    }

}
- (IBAction)btnEventos:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController * mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - App Ecoturismo - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"eventos@revistaecoturismo.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else {
        
        [self MessagemAlerta];
        
    }

}



-(void) MessagemAlerta{
    
    UIAlertController * view =  [UIAlertController
                                 alertControllerWithTitle:@"Falha"
                                 message:@"Este dispositivo não suporta o envio de e-mail."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction
                          actionWithTitle:@"Ok"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action) {
                              
                              [view dismissViewControllerAnimated:YES completion:nil];
                              
                          }];
    
    [view addAction:ok];
    [self presentViewController:view animated:NO completion:nil];
}



- (IBAction)btnSite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.revistacorrer.com.br"]];
    
}

- (IBAction)btnLigar:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:1641413080"]];
}



@end

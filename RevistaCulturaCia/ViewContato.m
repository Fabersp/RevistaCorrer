//
//  ViewContato.m
//  SidebarDemo
//
//  Created by Fabricio Aguiar de Padua on 08/05/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "ViewContato.h"




@interface ViewContato ()

@end

@implementation ViewContato

@synthesize contato;
@synthesize contarumamigo;
@synthesize site;
@synthesize btnAnuncieApp;

@synthesize ViewApper;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Configure the view for the selected state
   /* UIColor *Laranja = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:34/255.0 alpha:1];
    
    contato.layer.cornerRadius = 7.0f;
    contato.layer.masksToBounds = YES;
    [contato setBackgroundColor:Laranja];
    
    contarumamigo.layer.cornerRadius = 7.0f;
    contarumamigo.layer.masksToBounds = YES;
    [contarumamigo setBackgroundColor:Laranja];
    
    site.layer.cornerRadius = 7.0f;
    site.layer.masksToBounds = YES;
    [site setBackgroundColor:Laranja];
    
    btnAnuncieApp.layer.cornerRadius = 7.0f;
    btnAnuncieApp.layer.masksToBounds = YES;
    [btnAnuncieApp setBackgroundColor:Laranja];
    
//    UIImageView* imglog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo140.png"]];
//    self.navigationItem.titleView = imglog;
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

- (IBAction)btnContato:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato App Ecoturismo - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"comercial@promastersolution.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.promastersolution.com.br"]];
    
}
- (IBAction)btnLigar:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:16992318863"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

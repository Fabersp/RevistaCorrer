//
//  TableJornal.m
//  RevistaCulturaCia
//
//  Created by Fabricio Padua on 13/09/16.
//  Copyright © 2016 Pro Master Solution. All rights reserved.
//

#import "TableJornal.h"

#import "CellCalendario.h"
#import "DatailsNew.h"
#import "MBProgressHUD.h"
#import <Photos/Photos.h>
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>
#import "QuartzCore/QuartzCore.h"



@interface TableJornal ()

@end

@implementation TableJornal

@synthesize pageImages;
@synthesize pastaEdicao;
@synthesize ObjetoJson;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        // self.title = @"MWPhotoBrowser";
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        // [self downloadImage];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    //    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    //self.navigationItem.titleView = imglog;
    
    [self Loading];
    
//    self.ViewBanner.adUnitID = @"ca-app-pub-6439752646521747/3908346117";
//    self.ViewBanner.rootViewController = self;
//    [self.ViewBanner loadRequest:[GADRequest request]];
//    
//    
//    GADRequest *request = [GADRequest request];
//    // Requests test ads on devices you specify. Your test device ID is printed to the console when
//    // an ad request is made. GADBannerView automatically returns test ads when running on a
//    // simulator.
//    request.testDevices = @[@"53434f5a4f0499df210a28721c0b74568d755c7c"];
//    
//    [self.ViewBanner loadRequest:request];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

-(void)Loading {
    if (internetActive){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.dimBackground = YES;
        
        NSURL * url = [NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/revistas/correr/calendario_ios.php"];
        
        NSURLSession * session = [NSURLSession sharedSession];
        
        NSURLSessionDownloadTask * task =
        [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
            news = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
                hud.hidden = YES;
                
            });
        }];
        [task resume];
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return news.count;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    float width = tableView.bounds.size.width;
//    int fontSize = 18;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, fontSize)];
//    view.backgroundColor = [UIColor colorWithWhite:40 alpha:0];
//    view.userInteractionEnabled = YES;
//    view.tag = section;
//    
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anuncie_Fotor.jpg"]];
//    
//    image.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [view addSubview:image];
//    
//    return view;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    CellCalendario *cell = (CellCalendario *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[CellCalendario alloc]initWithStyle:
               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString * destaque = [[news objectAtIndex:indexPath.row] objectForKey:@"destaque"];
    
    UIColor *CinzaEscuro = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    
    if ([destaque isEqualToString:@"1"])
        cell.backgroundColor = CinzaEscuro;
        
        
    
    
    cell.lbCidadeEstado.text = [[news objectAtIndex:indexPath.row] objectForKey:@"Cidade"];
    cell.lbdia.text          = [[news objectAtIndex:indexPath.row] objectForKey:@"dia"];
    
    cell.lbMes.text          = [self RetornarStringMes:[[news objectAtIndex:indexPath.row] objectForKey:@"mes"]];
    
    cell.NomeCorrida.text    = [[news objectAtIndex:indexPath.row] objectForKey:@"Informacoes"];
    
    NSString * valor = [[news objectAtIndex:indexPath.row] objectForKey:@"Valor"];
    
    cell.ValorCorrida.text   = [NSString stringWithFormat:@"Valor: %@", valor];
    
    NSString * distancia = [[news objectAtIndex:indexPath.row] objectForKey:@"distancia"];
    
    cell.distancia.text      = [NSString stringWithFormat:@"Distância: %@", distancia];
    
    return cell;
}

-(NSString *)RetornarStringMes:(NSString *) mes {
   
    NSString * result;
    
    if ([mes isEqualToString:@"01"]){
        result =  @"Jan";
    } else if ([mes isEqualToString:@"02"]){
        result =  @"Fev";
    } else if ([mes isEqualToString:@"03"]){
        result =  @"Mar";
    } else if ([mes isEqualToString:@"03"]){
        result =  @"Abr";
    } else if ([mes isEqualToString:@"05"]){
        result =  @"Mai";
    } else if ([mes isEqualToString:@"06"]){
        result =  @"Jun";
    } else if ([mes isEqualToString:@"07"]){
        result =  @"Jul";
    } else if ([mes isEqualToString:@"08"]){
        result =  @"Ago";
    } else if ([mes isEqualToString:@"09"]){
        result =  @"Set";
    } else if ([mes isEqualToString:@"10"]){
        result =  @"Out";
    } else if ([mes isEqualToString:@"11"]){
        result =  @"Nov";
    } else if([mes isEqualToString:@"12"]){
        result =  @"Dez";
    }

    return result;
}

//--------------- Verificar a internet -----------------//
-(void) viewWillAppear:(BOOL)animated {
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    hostReachable = [Reachability reachabilityWithHostName:@"www.revide.com.br"];
    [hostReachable startNotifier];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)MensagemErro{
    
    // Add a button inside the message
    [TSMessage showNotificationInViewController:self
                                          title:@"Sem conexão com a intenet"
                                       subtitle:nil
                                          image:nil
                                           type:TSMessageNotificationTypeError
                                       duration:10.0
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:^{
                                     NSLog(@"User tapped the button");
                                     
                                 }
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}


-(void) checkNetworkStatus:(NSNotification *)notice {
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable: {
            [self MensagemErro];
            self->internetActive = NO;
            break;
        }
        case ReachableViaWiFi: {
            self->internetActive = YES;
            [self Loading];
            
            break;
        }
        case ReachableViaWWAN: {
            self->internetActive = YES;
            [self Loading];
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
        case NotReachable: {
            NSLog(@"Estamos com instabilidade no site neste momento, tente mais tarde...");
            self->hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi: {
            self->hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN: {
            self->hostActive = YES;
            
            break;
        }
    }
}

- (IBAction)btnAnuncie:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.rangelracingteam.com.br"]];

    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
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






@end

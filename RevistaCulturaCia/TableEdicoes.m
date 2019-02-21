//
//  TableEdicoes.m
//  RevistaCulturaCia
//
//  Created by Fabricio Padua on 21/05/16.
//  Copyright © 2016 Pro Master Solution. All rights reserved.
//

#import "TableEdicoes.h"

#import "CellNews.h"
#import "DatailsNew.h"
#import "MBProgressHUD.h"
#import <Photos/Photos.h>
#import "Reachability.h"
#import <TSMessages/TSMessageView.h>
#import "QuartzCore/QuartzCore.h"



@interface TableEdicoes () {
    
    UIRefreshControl *refreshControl;
    
}

@end

@implementation TableEdicoes

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
    
    // verificar se a pasta não existe //
    
    
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
        
        NSURL * url = [NSURL URLWithString:@"http://www.promastersolution.com.br/x7890_IOS/revistas/correr/revista_ios.php"];
        NSURLSession * session = [NSURLSession sharedSession];
        
        NSURLSessionDownloadTask * task =
        [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
            news = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
                [refreshControl endRefreshing];
                
                hud.hidden = YES;
                
                
                NSUserDefaults * btnDownload = [NSUserDefaults standardUserDefaults];
                
                for (NSInteger i = 0; i < news.count; i ++) {
                    
                    NSString * ID = [[news objectAtIndex:i] objectForKey:@"ID"];
                    NSString * VerificaEdicao = [btnDownload valueForKey:ID]; // esta Salvando o numero da ID ex. 1, 2, 3, 4, 5 do tipo bool
                    
                    if (VerificaEdicao == NULL) {
                        [btnDownload setBool:false forKey:ID];
                    }
                }
                [btnDownload synchronize];
            });
        }];
        [task resume];
    }
    
}
- (IBAction)teste:(id)sender {
    // Perguntar se quer apagar ou não //
    if ([self checkIfDirectoryAlreadyExists:@"Revista"]) {
        
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Mensagem"
                                     message:@"Deseja excluir todas as Edições??"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction
                              actionWithTitle:@"Sim"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [self removeImage:@"Revista"];
                                  
                                  // limpar os dados salvos para voltar o botao ativo //
                                  NSUserDefaults * btnDownload = [NSUserDefaults standardUserDefaults];
                                  
                                  for (NSInteger i = 0; i < news.count; i ++) {
                                      
                                      NSString * ID = [[news objectAtIndex:i] objectForKey:@"ID"];
                                      
                                      [btnDownload setBool:false forKey:ID];
                                      
                                  }
                                  
                                  [btnDownload synchronize];
                                  
                                  [self.tableView reloadData];
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Não"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [view addAction:ok];
        [view addAction:cancel];
        [self presentViewController:view animated:NO completion:nil];
        
    } else {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Mensagem"
                                     message:@"Não existem edições para ser excluída"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        [view addAction:ok];
        [self presentViewController:view animated:NO completion:nil];
    }
}

- (void)removeImage:(NSString *)filename
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:filename];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        NSLog(@"Pasta Apagada %@ ", filename);
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    float width = tableView.bounds.size.width;
    int fontSize = 18;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, fontSize)];
    view.backgroundColor = [UIColor colorWithWhite:40 alpha:0];
    view.userInteractionEnabled = YES;
    view.tag = section;
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anuncie_Fotor.jpg"]];
    
    image.contentMode = UIViewContentModeScaleAspectFit;
    
    [view addSubview:image];
    
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Item";
    
    CellNews *cell = (CellNews *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[CellNews alloc]initWithStyle:
               UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.lbTitulo.text = [[news objectAtIndex:indexPath.row] objectForKey:@"EDICAO"];
    cell.lbDetalhe.text = [[news objectAtIndex:indexPath.row] objectForKey:@"MODELO"];
    NSURL * urlImage = [NSURL URLWithString:[[news objectAtIndex:indexPath.row] objectForKey:@"URLIMAGEM"]];
    cell.lbTumbImage.image = [UIImage imageNamed:@"image.png"];
    
    cell.btnDownload.tag = indexPath.row;   // ex.Tag = 0
    [cell.btnDownload addTarget:self action:@selector(btnDownloadClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Qual é o ID que está na tag 0 //
    NSString * IDRow = [[news objectAtIndex:indexPath.row] objectForKey:@"ID"]; // ex. ID = 1
    
    // abrir NSUserDefaults * btnDownload pra ver se foi setado o valor true //
    NSUserDefaults * btnDownload = [NSUserDefaults standardUserDefaults];
    bool VerificaEdicao = [btnDownload boolForKey:IDRow]; // recebe o valor  true or false
    
    
    [cell.btnDownload setHidden:VerificaEdicao];
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CellNews * updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.lbTumbImage.image = image;
                });
            }
        }
    }];
    [task resume];
    
    cell.lbTime.text = [[news objectAtIndex:indexPath.row] objectForKey:@"DETALHE"];
    
    return cell;
}

- (void)btnDownloadClick:(UIButton *)sender {
    
    if (internetActive){
        NSLog(@"Array: %@", news);
        
        // realizar donload aqui //
        NSString * IDSalvar =  [[news objectAtIndex:sender.tag] objectForKey:@"ID"];
        
        NSString * pasta    = [NSString stringWithFormat:@"Revista/%@",[[news objectAtIndex:sender.tag] objectForKey:@"PASTA"]];
        NSString * URL      = [[news objectAtIndex:sender.tag] objectForKey:@"URLREVISTA"];
        NSInteger Paginas   = [[[news objectAtIndex:sender.tag] objectForKey:@"num_paginas"] integerValue];
        
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Mensagem"
                                     message:@"Deseja realizar o download desta edição?"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction
                              actionWithTitle:@"Sim"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //Do some thing here
                                  // verifica qual é o ID que será setado na memória //
                                  if (![self checkIfDirectoryAlreadyExists:@"Revista"]) {
                                      [self criarPasta:@"Revista"];
                                  }
                                  
                                  if (![self checkIfDirectoryAlreadyExists:pasta]) {
                                      [self criarPasta:pasta];
                                      
                                      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                                      
                                      hud.mode = MBProgressHUDModeDeterminate;
                                      hud.dimBackground = YES;
                                      //    hud..text = NSLocalizedString(@"Carregando...", @"HUD loading title");
                                      
                                      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                                          // Do something useful in the background and update the HUD periodically.
                                          [self downloadImage2:pasta :URL :Paginas];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              hud.hidden = YES;// hideAnimated:YES];
                                              // ex. ID = 1  e o Sender = 0
                                              
                                              NSUserDefaults * btnDownload = [NSUserDefaults standardUserDefaults];
                                              [btnDownload setBool:true forKey:IDSalvar];
                                              [btnDownload synchronize];
                                              
                                              // recarregar a tableview com a tag do sender button //
                                              [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                                          });
                                      });
                                  }
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Não"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [view addAction:ok];
        [view addAction:cancel];
        [self presentViewController:view animated:NO completion:nil];
    }
    
}

-(void) criarPasta:(NSString * ) pasta {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:pasta];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
}

-(BOOL)checkIfDirectoryAlreadyExists:(NSString *)name{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:name];
    
    BOOL isDir;
    BOOL fileExists = [fileManager fileExistsAtPath:dataPath isDirectory:&isDir];
    
    if (fileExists){
        NSLog(@"Existe Arquivo...");
        
        if (isDir) {
            NSLog(@"Folder already exists...");
        }
    }
    return fileExists;
}

-(void) BucarDadosPasta :(NSString *) Pasta{
    
    pageImages = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:Pasta];
    
    NSArray * dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:NULL];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"jpg"]) {
            [pageImages addObject:[dataPath stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"Array: %@ ", pageImages);
    
}


-(void) downloadImage2 :(NSString *) pasta :(NSString *) URL :(NSInteger ) Paginas {
    
    // montar o array das urls das imagens //
    for ( NSInteger i = 0; i < Paginas; i++){
        
        NSString * Contador = [NSString stringWithFormat:@"%.3ld", (long)i + 1];
        NSString * UrlMontadada = [NSString stringWithFormat:@"%@/%@.jpg", URL, Contador];
        
        NSURL  *url = [NSURL URLWithString:UrlMontadada];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData ) {
            // pega o nome do arquivo //
            NSArray *parts = [UrlMontadada componentsSeparatedByString:@"/"];
            NSString *filename = [parts lastObject];
            
            // busca a pasta oficial do App //
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            // add na frente da pasta ofical o caminho ex: /Revista/Edicao22  //
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:pasta];
            // monta o caminho para ser salvo os aquivos //
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", dataPath, filename];
            // salva os aquivos na pasta //
            //saving is done on main thread
            float ratio = (float)i  / (float)Paginas;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Instead we could have also passed a reference to the HUD
                // to the HUD to myProgressTask as a method parameter.
                [MBProgressHUD HUDForView:self.navigationController.view].progress = (float)ratio;
            });
            usleep(50000);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                
            });
            
        }
    }
}
- (IBAction)btnAnuncieAqui:(id)sender {
    
    
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




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ObjetoJson = [news objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString * pasta   = [NSString stringWithFormat:@"Revista/%@",[ObjetoJson objectForKey:@"PASTA"]];
    
    if (![self checkIfDirectoryAlreadyExists:pasta]) {
        // Avisar que precisa ser feito o Download //
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Erro"
                                     message:@"Para visualizar esta Edição é necessário fazer o Donwload!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction
                              actionWithTitle:@"Ok"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //Do some thing here
                                  // verifica qual é o ID que será setado na memória //
                                  
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        
        [view addAction:ok];
        
        [self presentViewController:view animated:NO completion:nil];
        
    } else {
        
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        //MWPhoto *photo;
        
        BOOL displayActionButton = YES;
        BOOL displaySelectionButtons = NO;
        BOOL displayNavArrows = NO;
        BOOL enableGrid = YES;
        BOOL startOnGrid = YES;
        BOOL autoPlayOnAppear = NO;
        
        // buscar e carregar fotos no array abaixo //
        
        [self BucarDadosPasta:pasta];
        
        for (NSInteger i = 0; i < pageImages.count; i++){
            
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:pageImages[i]];
            
            [photos addObject:[MWPhoto photoWithURL:fileURL]];
        }
        
        self.photos = photos;
        // Create browser
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = displayActionButton;
        browser.displayNavArrows = displayNavArrows;
        browser.displaySelectionButtons = displaySelectionButtons;
        browser.alwaysShowControls = displaySelectionButtons;
        browser.zoomPhotosToFill = YES;
        browser.enableGrid = enableGrid;
        browser.startOnGrid = startOnGrid;
        browser.enableSwipeToDismiss = NO;
        browser.autoPlayOnAppear = autoPlayOnAppear;
        [browser setCurrentPhotoIndex:0];
        
        
        // Reset selections
        if (displaySelectionButtons) {
            _selections = [NSMutableArray new];
            for (int i = 0; i < photos.count; i++) {
                [_selections addObject:[NSNumber numberWithBool:NO]];
            }
        }
        [self.navigationController pushViewController:browser animated:YES];
    }
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
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


@end


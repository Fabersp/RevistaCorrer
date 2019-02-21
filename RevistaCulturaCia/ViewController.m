//
//  ViewController.m
//  RevistaCulturaCia
//
//  Created by Fabricio Padua on 21/05/16.
//  Copyright © 2016 Pro Master Solution. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

@synthesize pageImages;

@synthesize pastaEdicao;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    pastaEdicao = @"Revista/Edicao22";
    
    NSString * URLRevista  = @"http://www.promastersolution.com.br/x7890_IOS/revistas/cultura/edicao23/";
    NSInteger npaginas     = 36;
    
    pageImages = [[NSMutableArray alloc] init];
    
    // verificar se a pasta não existe //
    if (![self checkIfDirectoryAlreadyExists:@"Revista"]) {
        [self criarPasta:@"Revista"];
    }
    
    if (![self checkIfDirectoryAlreadyExists:pastaEdicao]) {
        [self criarPasta:pastaEdicao];
        
        // montar o array das urls das imagens //
        for ( NSInteger i = 0; i < npaginas; i++){
            
            NSString * Contador = [NSString stringWithFormat:@"%.3ld", (long)i + 1];
            NSString * UrlMontadada = [NSString stringWithFormat:@"%@/%@.png", URLRevista, Contador];
            [self downloadImageFromURL:UrlMontadada : pastaEdicao];
        }
    }
    NSLog(@"Donwload Realizado...");
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

-(void) downloadImageFromURL :(NSString *)imageUrl  :(NSString * )Pasta{
    //download the file in a seperate thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL  *url = [NSURL URLWithString:imageUrl];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData ) {
            
            // pega o nome do arquivo //
            NSArray *parts = [imageUrl componentsSeparatedByString:@"/"];
            NSString *filename = [parts lastObject];
            
            // busca a pasta oficial do App //
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            // add na frente da pasta ofical o caminho ex: /Revista/Edicao22  //
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:Pasta];
            // monta o caminho para ser salvo os aquivos //
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", dataPath, filename];
            // salva os aquivos na pasta //
            //saving is done on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                [pageImages addObject:filePath];
            });
            
        } else {
            NSLog(@"Erro no download...");
        }
    });
    
}

- (IBAction)btnbusar:(id)sender {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:pastaEdicao];
    
    NSArray * dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:NULL];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"png"]) {
            [pageImages addObject:[dataPath stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"Array: %@ ", pageImages);
    
    UIImage * image1 = [UIImage imageWithContentsOfFile:pageImages[0]];
    _imageview.image = image1;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

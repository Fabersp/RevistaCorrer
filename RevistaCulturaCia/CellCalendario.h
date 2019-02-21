//
//  CellCalendario.h
//  RevistaCulturaCia
//
//  Created by Fabricio Padua on 22/09/16.
//  Copyright © 2016 Pro Master Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellCalendario : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lbdia;

@property (weak, nonatomic) IBOutlet UILabel *lbMes;
@property (weak, nonatomic) IBOutlet UILabel *lbCidadeEstado;
@property (weak, nonatomic) IBOutlet UILabel *NomeCorrida;
@property (weak, nonatomic) IBOutlet UILabel *ValorCorrida;
@property (weak, nonatomic) IBOutlet UILabel *distancia;

@end

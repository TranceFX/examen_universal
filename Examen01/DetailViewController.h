//
//  DetailViewController.h
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Noticia.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel   *titleDetail;
@property (strong, nonatomic) IBOutlet UILabel   *subDetail;
@property (strong, nonatomic) IBOutlet UIImageView   *imageDetail;
@property (strong, nonatomic) IBOutlet UITextView    *textBodyDetail;
@property (strong, nonatomic) IBOutlet UILabel       *captionText;

@property (strong, nonatomic) Noticia  *nota;

@end

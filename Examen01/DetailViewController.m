//
//  DetailViewController.m
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import "DetailViewController.h"
#import <Social/Social.h>

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize nota;
@synthesize titleDetail, textBodyDetail, captionText, imageDetail, subDetail;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleDetail.text = nota.titleNoticia;
    subDetail.text   = nota.summaryNoticia;
    textBodyDetail.text = nota.bodyNoticia;
    captionText.text = nota.captionNoticia;
    imageDetail.image = [UIImage imageWithData:nota.dataImageNoticia];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareWithFriends)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareWithFriends{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Compartir" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    [alerta addAction:cancel];
    
    UIAlertAction* twit = [UIAlertAction actionWithTitle:@"Twittear" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweet setInitialText:nota.urlNoticia];
            [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 if (result == SLComposeViewControllerResultCancelled)
                 {
                     NSLog(@"Cancelado por el usuario");
                 }
                 else if (result == SLComposeViewControllerResultDone)
                 {
                     NSLog(@"Tweet Enviado");
                 }
             }];
            [self presentViewController:tweet animated:YES completion:nil];
        }else{
            NSLog(@"Fallo");
            UIAlertController *alerta2 = [UIAlertController alertControllerWithTitle:@"Atención" message:@"Revisa tu cuenta de twitter, ya que no esta disponible" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancel2 = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:nil];
            [alerta2 addAction:cancel2];
            [self presentViewController:alerta2 animated:YES completion:nil];
        }
    }];
    [alerta addAction:twit];
    
    UIAlertAction* face = [UIAlertAction actionWithTitle:@"Compartir Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *face2 = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [face2 setInitialText:nota.urlNoticia];
            [face2 setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 if (result == SLComposeViewControllerResultCancelled)
                 {
                     NSLog(@"Cancelado por el usuario");
                 }
                 else if (result == SLComposeViewControllerResultDone)
                 {
                     NSLog(@"El usuario compartio en Facebook");
                 }
             }];
            [self presentViewController:face2 animated:YES completion:nil];
        }else{
            NSLog(@"Fallo");
            UIAlertController *alerta3 = [UIAlertController alertControllerWithTitle:@"Atención" message:@"Revisa tu cuenta de Facebook, ya que no esta disponible" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancel3 = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:nil];
            [alerta3 addAction:cancel3];
            [self presentViewController:alerta3 animated:YES completion:nil];
        }
    }];
    [alerta addAction:face];
    
    [self presentViewController:alerta animated:YES completion:nil];
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

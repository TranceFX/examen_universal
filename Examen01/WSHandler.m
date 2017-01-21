//
//  WSHandler.m
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import "WSHandler.h"
#import "Noticia.h"

@implementation WSHandler{
    NSString        *url;
    NSMutableArray *containerNoticias;
}
@synthesize delegate;

- (id)init{
    self = [super init];
    if (self) {
        //
        containerNoticias = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)loadNoticiasByID:(int)number{
    url = [[NSString alloc] initWithFormat:UNIVERSAL_WS, [NSString stringWithFormat:@"%d", number]];
    [self connectToServer];
}

- (void)connectToServer{
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data != nil) {
                                                    NSError *error = nil;
                                                    NSMutableArray *infoResult = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                    //NSLog(@"Informacion: %@", infoResult);
                                                    for (NSDictionary *dict in infoResult) {
                                                        Noticia *nota = [[Noticia alloc] init];
                                                        [nota setTitleNoticia:[dict valueForKey:@"title"]];
                                                        [nota setSummaryNoticia:[dict valueForKey:@"summary"]];
                                                        [nota setCaptionNoticia:[dict valueForKey:@"caption"]];
                                                        [nota setBodyNoticia:[dict valueForKey:@"body"]];
                                                        [nota setUrlImage:[dict valueForKey:@"image"]];
                                                        [nota setUrlNoticia:[dict valueForKey:@"link"]];
                                                        [containerNoticias addObject:nota];
                                                    }
                                                    //NSLog(@"Contenedor: %@", containerNoticias);
                                                    [delegate sucessResponse:containerNoticias];
                                                    [self downloadImages];
                                                }else{
                                                    [delegate failResponse:[NSString stringWithFormat:@"%@", [error description]]];
                                                }
    }];
    [task resume];
}

- (void)downloadImages{
    for (Noticia *not in containerNoticias) {
        if (not.dataImageNoticia == nil) {
            NSURL *urlImage = [NSURL URLWithString:not.urlImage];
            NSURLRequest *reqImages = [NSURLRequest requestWithURL:urlImage];
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *imageTask = [session dataTaskWithRequest:reqImages
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                             if (data != nil) {
                                                                 not.dataImageNoticia = data;
                                                                 [delegate loadImages:containerNoticias];
                                                             }else{
                                                                 [delegate failResponse:[NSString stringWithFormat:@"%@", [error description]]];
                                                             }
                                                         }];
            [imageTask resume];
        }
            
    }
}

@end

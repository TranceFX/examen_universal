//
//  Noticia.h
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Noticia : NSObject

@property (nonatomic, retain) NSString * titleNoticia;
@property (nonatomic, retain) NSString * captionNoticia;
@property (nonatomic, retain) NSString * summaryNoticia;
@property (nonatomic, retain) NSString * bodyNoticia;
@property (nonatomic, retain) NSString * urlNoticia;
@property (nonatomic, retain) NSString * urlImage;
@property (nonatomic, retain) NSData   * dataImageNoticia;

@end

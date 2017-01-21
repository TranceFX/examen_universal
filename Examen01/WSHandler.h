//
//  WSHandler.h
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WSHandlerDelegate<NSObject>
- (void)sucessResponse:(NSMutableArray *)arreglo;
- (void)failResponse:(NSString *)message;
- (void)loadImages:(NSMutableArray *)images;
@end

@interface WSHandler : NSObject

@property (nonatomic, weak) id<WSHandlerDelegate> delegate;

- (void)loadNoticiasByID:(int)number;

@end

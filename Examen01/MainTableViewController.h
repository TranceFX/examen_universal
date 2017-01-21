//
//  MainTableViewController.h
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSHandler.h"
#import "MNMBottomPullToRefreshManager.h"

@interface MainTableViewController : UITableViewController<WSHandlerDelegate, MNMBottomPullToRefreshManagerClient, UIScrollViewDelegate>{
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
}

@end

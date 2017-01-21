//
//  MainTableViewController.m
//  Examen01
//
//  Created by Juan Casillas on 21/01/17.
//  Copyright © 2017 Juan Casillas. All rights reserved.
//

#import "MainTableViewController.h"
#import "CustomViewCell.h"
#import "Noticia.h"
#import "DetailViewController.h"

@interface MainTableViewController (){
    NSMutableArray *noticias;
    int contador;
    WSHandler *handler;
}

- (void)loadTable;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    noticias = [[NSMutableArray alloc] init];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    handler = [[WSHandler alloc] init];
    handler.delegate = self;
    [handler loadNoticiasByID:0];
    
    contador = 0;
    
    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                         tableView:self.tableView
                                                                                        withClient:self];
}

- (void)loadTable {
    contador += 1;
    [handler loadNoticiasByID:contador];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [pullToRefreshManager_ relocatePullToRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [noticias count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([noticias count] != 0) {
        cell.titleInfo.text = [(Noticia *)[noticias objectAtIndex:indexPath.row] titleNoticia];
        cell.descInfo.text = [(Noticia *)[noticias objectAtIndex:indexPath.row] summaryNoticia];
        
        if ([(Noticia *)[noticias objectAtIndex:indexPath.row] dataImageNoticia] != nil) {
            cell.thumbImage.image = [UIImage imageWithData:[(Noticia *)[noticias objectAtIndex:indexPath.row] dataImageNoticia]];
        }
    }

    return cell;
}

#pragma mark - WSDelegates -
- (void)sucessResponse:(NSMutableArray *)arreglo{
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        [noticias removeAllObjects];
        [noticias addObjectsFromArray:arreglo];
        [self.tableView reloadData];
        [pullToRefreshManager_ tableViewReloadFinished];
    });
}

- (void)failResponse:(NSString *)message{
    [pullToRefreshManager_ tableViewReloadFinished];
}

- (void)loadImages:(NSMutableArray *)images{
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        [noticias removeAllObjects];
        [noticias addObjectsFromArray:images];
        [self.tableView reloadData];
        [pullToRefreshManager_ tableViewReloadFinished];
    });
}

#pragma mark - Table Delegates -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"detailNoticias"];
    details.nota = (Noticia *)[noticias objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark MNMBottomPullToRefreshManagerClient

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [pullToRefreshManager_ tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [pullToRefreshManager_ tableViewReleased];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


//#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end

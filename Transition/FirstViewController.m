//
//  ViewController.m
//  Transition
//
//  Created by SurfBoy on 9/24/15.
//  Copyright © 2015 Crazy.Surfboy. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Animator.h"

@interface FirstViewController ()

@property (strong, nonatomic) Animator* animator;
@property(assign) float imageHeight;

@end

@implementation FirstViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // Init
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"列表";
    self.imageHeight = SCREEN_WDITH/ 2.5;
    self.view.backgroundColor = [UIColor cloudsColor];

    // UITableView
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0, SCREEN_WDITH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    [self.listTableView setDelegate:self];
    [self.listTableView setDataSource:self];
    [self.listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.listTableView];
 
    // 初始化
    self.animator = [Animator new];

}

- (void)viewDidAppear:(BOOL)animated {

    self.navigationController.delegate = self;
    
}


#pragma mark -
#pragma mark -# UINavigationControllerDelegate


// Called to allow the delegate to return a noninteractive animator object for use during view controller transitions.
// 我们从这里实现我们的自定义Push动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    if (operation == UINavigationControllerOperationPush) {
        self.animator.isPush = YES;
        return self.animator;
    }

    return nil;
}


#pragma mark -
#pragma mark -#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 

    return 10; 
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Row cell
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        // 图像
        UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 10.0, SCREEN_WDITH, self.imageHeight)];
        photoImageView.tag = 10;
        [cell.contentView addSubview:photoImageView];

        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 175.0, SCREEN_WDITH, 20.0)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorFromHexCode:@"000000"];
        titleLabel.tag = 12;
        [cell.contentView addSubview:titleLabel];

        // 内容标题
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 200.0, SCREEN_WDITH, 20.0)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.textColor = [UIColor colorFromHexCode:@"666666"];
        contentLabel.tag = 13;
        [cell.contentView addSubview:contentLabel];

        

    }

    // 图片
    UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:10];
    [photoImageView setImage:[UIImage imageNamed:@"l1.png"]];

    // 标题
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:12];
    titleLabel.text = @"北京直飞大板5/7天往返含税机票";

    // 内容
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:13];
    contentLabel.text = @"八月、十月、12月";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"didSelectRowAtIndexPath");

    // Add a custom "back" button for UINavigationController
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style: UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:nil];

    // SecondViewController
    SecondViewController *viewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// Asks the delegate for the height to use for a row in a specified location.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 227;
}





@end

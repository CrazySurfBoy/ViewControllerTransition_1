//
//  SecondViewController.m
//  Transition
//
//  Created by SurfBoy on 9/28/15.
//  Copyright © 2015 Crazy.Surfboy. All rights reserved.
//



#import "SecondViewController.h"
#import "Animator.h"

@interface SecondViewController ()

@property (strong, nonatomic) Animator* animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;



/**
 *  左边缘手势
 *
 *  @param UIScreenEdgePanGestureRecognizer 
 *  
 */
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer*)recognizer;

@end

@implementation SecondViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    float imageHeight = SCREEN_WDITH/ 2.5;

    // 图片
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 10.0, SCREEN_WDITH, imageHeight)];
    [photoImageView setImage:[UIImage imageNamed:@"l1.png"]];
    [self.view addSubview:photoImageView];

    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 200, SCREEN_WDITH - 30, 21.0)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"北京直飞大板5/7天往返含税机票";
    [self.view addSubview:titleLabel];


    // 内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 220.0, SCREEN_WDITH - 40, 120.0)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.text = @"八月、十月、12月";
    [self.view addSubview:contentLabel];


    // 当用户从屏幕边缘左半部分开始滑动的时候，我们才把动画效果设为交互式
    UIScreenEdgePanGestureRecognizer* edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.navigationController.view addGestureRecognizer:edgePanGestureRecognizer];

    // Init
    self.animator = [[Animator alloc] init];
}




// 左边缘手势
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer*)recognizer {

    UIView *view = self.view; 

    // 计算你手指滑动占屏幕的百分比，这个和你滑动的距离无关
    CGFloat percent = [recognizer translationInView:self.view].x / self.view.bounds.size.width;

    // 手势开始,创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } 
    else if (recognizer.state == UIGestureRecognizerStateChanged) {

        // 手指滑动占屏幕的百分比告诉 UIPercentDrivenInteractiveTransition
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));

        // d 为什么除么5？主要是为了让过渡更加的平缓，可自行调整
        [self.interactionController updateInteractiveTransition:d/5];
    } 
    else if (recognizer.state == UIGestureRecognizerStateEnded) {

        // 当手指滑动占屏幕超过50%的时间，认为已经完成.否则取消
        if (percent > 0.5) {
            [self.interactionController finishInteractiveTransition];
        } 
        else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark -# UINavigationControllerDelegate

// Called to allow the delegate to return a noninteractive animator object for use during view controller transitions.
// 我们从这里实现我们的自定义Push动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    if (operation == UINavigationControllerOperationPop) {
        
        return self.animator;
   }


    return nil;
}


// Called to allow the delegate to return an interactive animator object for use during view controller transitions.
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {

    return self.interactionController;
}

@end

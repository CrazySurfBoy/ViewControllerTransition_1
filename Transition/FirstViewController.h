//
//  ViewController.h
//  Transition
//
//  Created by SurfBoy on 9/24/15.
//  Copyright © 2015 Crazy.Surfboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FirstViewController : UIViewController <UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *listTableView;

@end


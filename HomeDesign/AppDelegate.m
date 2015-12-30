//
//  AppDelegate.m
//  HomeDesign
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DiyViewController.h"
#import "UserViewController.h"
@interface AppDelegate ()

@property (nonatomic)NSMutableArray *titles;
@property (nonatomic)NSMutableArray *normalImages;
@property (nonatomic)NSMutableArray *selectedImages;
@property (nonatomic)NSMutableArray *classNames;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initDataSource];
    
    [self createControllers];
    
    return YES;
}

#pragma mark - 初始化数据源
- (void)initDataSource{
    _titles = [NSMutableArray array];
    _normalImages = [NSMutableArray array];
    _selectedImages = [NSMutableArray array];
    _classNames = [NSMutableArray array];
    
     NSString *plistFile = [[NSBundle mainBundle]pathForResource:@"tabbar" ofType:@"plist"];
    NSArray *plistItems = [NSArray arrayWithContentsOfFile:plistFile];
    for (NSDictionary *plistItem in plistItems) {
        NSString *title = plistItem[@"title"];
        NSString *normalImage = plistItem[@"normalImage"];
        NSString *selectedImage = plistItem[@"selectedImage"];
        NSString *className = plistItem[@"className"];
        [_titles addObject:title];
        [_normalImages addObject:normalImage];
        [_selectedImages addObject:selectedImage];
        [_classNames addObject:className];
    }
   
}

#pragma mark -创建分页视图
- (void)createControllers{
    
    UITabBarController *tbc = [[UITabBarController alloc]init];
   // NSArray *titles = @[@"首页",@"创意生活",@"个人中心"];
   // NSArray *classNames = @[@"HomeViewController",@"DiyViewController",@"UserViewController"];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSInteger i = 0 ; i<_classNames.count; i++) {
        
        Class cls =NSClassFromString(_classNames[i]);
        UIViewController *vc =[[cls alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
        nc.navigationBar.translucent = NO;
        vc.title = _titles[i];
        
        
        nc.tabBarItem = [[UITabBarItem alloc]initWithTitle:_titles[i] image:[UIImage imageNamed:_normalImages[i]] selectedImage:[[UIImage imageNamed:_selectedImages[i] ]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
        //nc.navigationBar.barTintColor = [UIColor colorWithRed:1 green:170/255.0 blue:0 alpha:1];
        //UIColor *normalColor = [UIColor colorWithRed:1 green:170/255.0 blue:0 alpha:1];
       // [nc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
        UIColor *selectedColor = [UIColor colorWithRed:1 green:107/255.0 blue:0 alpha:1];
        [nc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:selectedColor} forState:UIControlStateSelected];
        
        [controllers addObject:nc];
    }
    tbc.tabBar.translucent=NO;
    tbc.viewControllers = controllers;
    self.window.rootViewController = tbc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

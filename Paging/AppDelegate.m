//
//  AppDelegate.m
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "AppDelegate.h"

#import "ReaderViewController.h"
#import "RJBookListViewController.h"
#import "SysSettingViewController.h"
#import "FileUtil.h"




@implementation AppDelegate
@synthesize tabBarController=_tabBarController;
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    /*
     升级须知
     每次app生新版本，
     1、appVersion加一
     2、然后在case中做对应修改
     */
    int appVersion=1;
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
//    NSLog(@"UDF_THEME:%@",[def valueForKey:UDF_THEME]);
    int currentVersion=[def integerForKey:UDF_CURRENT_VERSION];
    if (appVersion!=currentVersion) { //未升级
        NSLog(@"app upgrade appVersion%d,currentVersion:%d",appVersion,currentVersion);
        switch (currentVersion) {
            case 0:
                //首次初始化
                [def setFloat:DEFAULT_ALPHA forKey:UDF_ALPHA];
                [def setInteger:DEFAULT_FONT_SIZE forKey:UDF_FONT_SIZE];
                [def setValue:[StringUtil int2String:DEFAULT_THEME] forKey:UDF_THEME];
                [def setValue:@"" forKey:UDF_LAST_READ_BOOK];
                [self copyResources];
            case 1:
                break;
        }
        [def setInteger:appVersion forKey:UDF_CURRENT_VERSION];
//        [def synchronize];
    }

    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
//    self.viewController = [[[ViewController alloc] initWithNibName:IS_IPAD?@"ViewController_ipad": @"ViewController_iphone" bundle:nil] autorelease];
    
    self.viewController = [[[RJBookListViewController alloc] init] autorelease];
//    self.viewController =[[[UIViewController alloc]init]autorelease];
    UINavigationController* navReader=[[[UINavigationController alloc]initWithRootViewController:self.viewController]autorelease];
    navReader.tabBarItem.title=@"我的书架";
    navReader.tabBarItem.image=[UIImage imageNamed:@"tool_reader"];
    
    SysSettingViewController * settingVC = [[[SysSettingViewController alloc] initWithNibName:@"SysSettingViewController" bundle:nil]autorelease];
    UINavigationController * navSetting = [[[UINavigationController alloc] initWithRootViewController:settingVC]autorelease];
    navSetting.tabBarItem.title=@"系统设置";
    navSetting.tabBarItem.image=[UIImage imageNamed:@"tool_setting"];
    
    NSArray * viewControllers = [NSArray arrayWithObjects:navReader,navSetting,nil];
    
    self.tabBarController = [[[UITabBarController alloc]init]autorelease];
    self.tabBarController.viewControllers = viewControllers;
    self.tabBarController.selectedIndex=0;
    self.tabBarController.delegate=self;
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
    

    
    return YES;
}

-(void)copyResources{
    NSString* srcPath=[[[NSBundle mainBundle] resourcePath ] stringByAppendingPathComponent:@"web"];
    
    NSString *dicpath = [NSString stringWithFormat:@"%@/Library/web",NSHomeDirectory()];
    
    [FileUtil copyFilesRecursiveOfType:nil inDirectory:srcPath toDir:dicpath deleteOldFiles:NO];
    NSString* srcPath2=[[[NSBundle mainBundle] resourcePath ] stringByAppendingPathComponent:@"resource"];
    
    NSString *dicpath2 = [NSString stringWithFormat:@"%@/Library/books",NSHomeDirectory()];
    
    [FileUtil copyFilesRecursiveOfType:nil inDirectory:srcPath2 toDir:dicpath2 deleteOldFiles:NO];

}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

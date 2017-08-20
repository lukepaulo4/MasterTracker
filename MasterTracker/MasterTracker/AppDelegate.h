//
//  AppDelegate.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/12/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

//need to initialize firebase
// [START auth_import]
@import Firebase;
// [END auth_import]

// [START signin_delegate]
@interface AppDelegate : UIResponder <UIApplicationDelegate>
// [END signin_delegate]



@property (strong, nonatomic) UIWindow *window;


@end


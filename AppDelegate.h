//
//  AppDelegate.h
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 29/7/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResults;

@interface AppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) SearchResults *searchResults;

-(void) switchWebView;
-(void) switchResultView;
@end

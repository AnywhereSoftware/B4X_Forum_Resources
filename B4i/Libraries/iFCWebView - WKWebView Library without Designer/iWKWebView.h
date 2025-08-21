//
//  iWKWebView.h
//  iWKWebView
//
//  Created by Fabio Campanella on 31/08/2019.
//  Copyright © 2019 Fabio Campanella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCore.h"


@class B4I;
/**
 * Improved version of WebView. It is based on the native WKWebView instead of UIWebView.
 * This is a custom view. It should be added from the designer.
 * OverrideUrl event allows you to cancel requests. Return True to cancel (override) the request.
 */
//~shortname:WKWebView2
//~ObjectWrapper: WKWebView*
//~Event:PageFinished (Success As Boolean, Url As String)
//~Event:OverrideUrl (Url As String) As Boolean
//~Event:JSComplete (Success As Boolean, Tag As Object, Result As String)
//~Version:0.90
@interface B4IWKWebViewWrapper: B4IObjectWrapper
/**
 * Returns the current page title.
 */
@property (nonatomic, readonly)NSString *Title;
/**
 * Returns the estimated loading progress. The returned value is between 0 to 1.
 */
@property (nonatomic, readonly)double EstimatedProgress;
/**
 * Loads a url. Note that you cannot use this method to load files from the Assets folder.
 * Example:<code>
 * WebView1.LoadUrl("http://www.google.com")</code>
 */
- (void)LoadUrl:(NSString *)Url;
/**
 * Loads the given html code. The path is relative to the assets folder.
 */
- (void)LoadHtml:(NSString *)Html;

//Returns true if the WebView can navigate to the previous page.
- (BOOL)CanGoBack;
//Returns true if the WebView can navigate forward.
- (BOOL)CanGoForward;
//Navigates to the previous page.
- (void)GoBack;
//Navigates to the next page in the stack of pages.
- (void)GoForward;
//Stops loading the current page.
- (void)StopLoading;
//Clear caches and reloads the current page.
- (void)Reload;
//Set Background Color
- (void)SetBackgroundColor:(UIColor *)color;
//Set Opacity
- (void)SetOpacity:(bool)opacity;
/**
 * Asynchronously evaluates the JavaScript. The JSComplete event will be raised.
 * Tag - An object that will be included in the event.
 * Script - The JavaScript to evaluate.
 */
- (void)EvaluateJavaScript:(NSObject *)Tag :(NSString *)Script;

//Initializes the object. The AuthorizationStatusChanged will be raised with the current status.
- (void)Initialize:(B4I *)bi :(NSString *)EventName;

@end

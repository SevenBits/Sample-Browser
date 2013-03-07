//
//  SBAppDelegate.h
//  SimpleBrowser
//
//  Created by SevenBits on 3/6/13.
//  Copyright (c) 2013 SevenBits. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface SBAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet WebView *primaryWebView;

- (IBAction)loadPage:(id)sender;

-(void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame;
-(void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;
- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame;
- (NSWindow *)downloadWindowForAuthenticationSheet:(WebDownload *)download;
- (void)webView:(WebView *)webView decidePolicyForMIMEType:(NSString *)type request:(NSURLRequest *)request
          frame:(WebFrame *)frame decisionListener:(id <WebPolicyDecisionListener>)listener;

@end

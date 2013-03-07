//
//  SBAppDelegate.m
//  SimpleBrowser
//
//  Created by SevenBits on 3/6/13.
//  Copyright (c) 2013 SevenBits. All rights reserved.
//

#import "SBAppDelegate.h"

@implementation SBAppDelegate

@synthesize primaryWebView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [primaryWebView setFrameLoadDelegate:self];
    [primaryWebView setDownloadDelegate:self];
    [primaryWebView setPolicyDelegate:self];
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"]; // Change this URL to load a different page on startup.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[primaryWebView mainFrame] loadRequest:request]; // We must get the main frame first, as web pages can have frames.
}

- (IBAction)loadPage:(id)sender {
    NSURL *shortURL = [[NSURL alloc] initWithString:[sender stringValue]];
    if (([[sender stringValue] rangeOfString:@"http://"].location == NSNotFound) && shortURL == nil) {
        NSString *initalString = @"https://duckduckgo.com/?q=";
        NSString *finalString = [NSString stringWithFormat:@"%@%@", initalString, [sender stringValue]];
        NSLog(@"%@", finalString);
        
        NSURL *url = [NSURL URLWithString:finalString]; // Change this URL to load a different page on startup.
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[primaryWebView mainFrame] loadRequest:request]; // We must get the main frame first, as web pages can have frames.
    } else {
        NSURL *url = [NSURL URLWithString:[sender stringValue]]; // Change this URL to load a different page on startup.
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[primaryWebView mainFrame] loadRequest:request]; // We must get the main frame first, as web pages can have frames.
    }
}

// Quit the application after we close its window.
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

#pragma marker WebView delegates
/*
 These are the delegates for the WebView. You may want to change/add to the code here. Please note that, due to caching,
 you will not necessarily see a loading message for each element on a page every time you load it.
 */

-(void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame {
    // Called before the page is loaded.
}

-(void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    // Called after the page is loaded.
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame {
    // Once we recieve the page's title, set that to be the title of our window.
    [_window setTitle:title];
}

- (NSWindow *)downloadWindowForAuthenticationSheet:(WebDownload *)download {
    return _window;
}

- (void)webView:(WebView *)webView decidePolicyForMIMEType:(NSString *)type request:(NSURLRequest *)request
          frame:(WebFrame *)frame decisionListener:(id <WebPolicyDecisionListener>)listener {
    if(![type isEqualToString:@"text/html"]) {
        [listener download];
    } else {
        [listener use];
    }
}

@end
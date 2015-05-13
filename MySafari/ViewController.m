//
//  ViewController.m
//  MySafari
//
//  Created by Brittany Kimbrough on 5/13/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *uiTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController
- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}
- (IBAction)onPlusButtonPressed:(id)sender {
        UIAlertView *alert = [UIAlertView new];
        alert.title = @"Coming Soon!";
        alert.message = @"Coming Soon!";
        [alert addButtonWithTitle:@"Coming Soon"];
        alert.delegate = self;
        [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self goToUrlString:@"http://www.google.com"];
}

-(void)goToUrlString:(NSString *)urlString {
    NSURL *url;
    if ([urlString hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:urlString];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlString]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToUrlString:textField.text];
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
    if ([self.webView canGoBack] == YES) {
        [self.backButton setEnabled: YES];
    } else {
        [self.backButton setEnabled: NO];
    }
    
    if ([self.webView canGoForward] == YES) {   
        [self.forwardButton setEnabled: YES];
    } else {
        [self.forwardButton setEnabled: NO];
    }
    webView.scrollView.scrollEnabled = TRUE;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView.contentOffset.y > 0.0){
        NSLog(@"Off top");
    }
}

@end


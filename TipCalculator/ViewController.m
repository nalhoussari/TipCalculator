//
//  ViewController.m
//  TipCalculator
//
//  Created by Noor Alhoussari on 2017-06-09.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrameNotificationHandler:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapGesture:(id)sender {
    // Tap the background
//    self.scrollView.contentOffset = CGPointZero;
    
    [self.view endEditing:YES];
}

- (IBAction)calculateTip15:(UIButton *)sender {
    
    //calculate tip 15%
    NSString *billAmountString = [self.billAmountTextField text];
    
    int tipAmountInt = 0;
    if ([billAmountString intValue]){
        int billAmountInt = [billAmountString intValue];
        tipAmountInt = (billAmountInt * 15) / 100;
        
        NSString *tipAmountString = [NSString stringWithFormat:@"Tip: %i$", tipAmountInt];
        //setting the amount to the label to display
        self.tipAmountLabel.text = tipAmountString;
    }
}

- (IBAction)calculateTipAnyPercentage:(UIButton *)sender {
    
    NSString *billAmountString = [self.billAmountTextField text];
    int billAmountInt = [billAmountString intValue];
    
    NSString *tipPercentageString = [self.tipPercentageTextField text];
    int tipPercentageInt = [tipPercentageString intValue];
    
    if ([billAmountString intValue] && [tipPercentageString intValue] ){
        int tipAmount = (billAmountInt * tipPercentageInt) / 100;
        
        NSString *tipAmountString = [NSString stringWithFormat:@"Tip: %i$", tipAmount];
        //setting the amount to the label to display
        self.tipAmountLabel.text = tipAmountString;
    } else {
        NSLog(@"WrongEntery");
    }
}


- (void)keyboardDidChangeFrameNotificationHandler:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSLog(@"Keyboard changed frame!!");
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    NSLog(@"Height: %f", keyboardHeight);
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = keyboardHeight;
        self.scrollView.contentInset = insets;
        self.scrollView.scrollIndicatorInsets = insets;
    } completion:^(BOOL finished) {
        [self.view setNeedsLayout];
    }];
}


- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.slider.minimumValue = 1;
    self.slider.maximumValue = 100;
    self.tipAmountLabel.text = [NSString stringWithFormat: @"%d%%", (int)self.slider.value];
}

@end

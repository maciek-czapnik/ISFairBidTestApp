//
//  ViewController.m
//  ISFairBidTestApp
//
//  Created by Maciek Czapnik on 01/04/2020.
//  Copyright © 2020 Maciek Czapnik. All rights reserved.
//

#import "ViewController.h"
#import <IronSource/IronSource.h>

#warning(please fill statics: mediationType, appKey, firstInterstitialInstancId and secondInterstitialInstanceId)
static NSString *const mediationType = @"";
static NSString *const appKey = @"";

static NSString *const firstInterstitialInstanceId = @"";
static NSString *const secondInterstitialInstanceId = @"";

@interface ViewController () <ISDemandOnlyInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIView *firstInstanceAvailabilityView;
@property (weak, nonatomic) IBOutlet UIView *secondInstanceAvailabilityView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstInstanceAvailabilityView.backgroundColor = [UIColor grayColor];
    self.secondInstanceAvailabilityView.backgroundColor = [UIColor grayColor];
    
    //setting ISDemanOnly delegates
    [IronSource setISDemandOnlyInterstitialDelegate:self];
    
    //setting mediation type
    [IronSource setMediationType:mediationType];
    
    //initializing
    [IronSource initISDemandOnly:appKey adUnits:@[IS_INTERSTITIAL]];

}

- (IBAction)loadFirstInstance:(id)sender {
    [IronSource loadISDemandOnlyInterstitial:firstInterstitialInstanceId];
}

- (IBAction)loadSecondInstance:(id)sender {
    [IronSource loadISDemandOnlyInterstitial:secondInterstitialInstanceId];
}

- (IBAction)showFirstInstance:(id)sender {
    if ([IronSource hasISDemandOnlyInterstitial:firstInterstitialInstanceId]) {
        [IronSource showISDemandOnlyInterstitial:self instanceId:firstInterstitialInstanceId];
    }
}

- (IBAction)showSecondInstance:(id)sender {
    if ([IronSource hasISDemandOnlyInterstitial:secondInterstitialInstanceId]) {
        [IronSource showISDemandOnlyInterstitial:self instanceId:secondInterstitialInstanceId];
    }
}

#pragma mark ISDemandOnlyInterstitialDelegate

- (void)interstitialDidLoad:(NSString *)instanceId {
    [self reportAvailability];
}

- (void)interstitialDidFailToLoadWithError:(NSError *)error instanceId:(NSString *)instanceId {
}

- (void)interstitialDidOpen:(NSString *)instanceId {
}

- (void)interstitialDidClose:(NSString *)instanceId {
    [self reportAvailability];
}

- (void)interstitialDidFailToShowWithError:(NSError *)error instanceId:(NSString *)instanceId {
}

- (void)didClickInterstitial:(NSString *)instanceId {
}

#pragma mark ad instanceid availability check

- (void)reportAvailability {
    self.firstInstanceAvailabilityView.backgroundColor = [IronSource hasISDemandOnlyInterstitial:firstInterstitialInstanceId] ? [UIColor greenColor] : [UIColor redColor];
    self.secondInstanceAvailabilityView.backgroundColor = [IronSource hasISDemandOnlyInterstitial:secondInterstitialInstanceId] ? [UIColor greenColor] : [UIColor redColor];
}

@end

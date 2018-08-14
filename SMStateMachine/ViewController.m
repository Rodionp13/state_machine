//
//  ViewController.m
//  SMStateMachine
//
//  Created by User on 8/14/18.
//  Copyright © 2018 BNR. All rights reserved.
//

#import "ViewController.h"
#import "SMStateMachine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SMStateMachine *sm = [[SMStateMachine alloc] initSMwithInitialState];
    [sm performStateWithEvent:successDbQuery];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  SMStateMachine.m
//  SMStateMachine
//
//  Created by User on 8/14/18.
//  Copyright © 2018 BNR. All rights reserved.
//

#import "SMStateMachine.h"

/*
 typedef NS_ENUM(NSInteger, SMState) {
 InitialState = 0,
 UpdateUI,
 LoadData,
 CheckNewData,
 SaveDataToDb,
 UpdateUIwithNewData,
 FailureState1,
 FailureState2,
 };
 
 typedef NS_ENUM(NSInteger, SMEvent) {
 failedDbQuery = 0,
 successDbQuery,
 connectionIsUp,
 connectionIsDown,
 successFetching,
 failedFetching,
 isNewLoadedData,
 isUpToData,
 isDataSaveToDb,
 failedToSaveDataToDb,
 };
 
*/

@interface SMStateMachine()
@property(assign, nonatomic, readwrite) SMState currentState;
@end

@implementation SMStateMachine

-(id)initSMwithInitialState {
    self = [super init];
    if(self) {
        _currentState = InitialState;
    }
    return self;
}

- (void)performStateWithEvent:(SMEvent)event {
    switch (event) {
        case successDbQuery:
            [self updateUIState:event]; break;
        case failedDbQuery:
            [self failureState1:event]; break;
        case connectionIsUp:
            [self loadDataState:event]; break;
        case connectionIsDown:
            [self fisailureState2:event]; break;
        case successFetching:
            [self checkForNewDataState:event]; break;
        case failedFetching:
            [self fisailureState2:event]; break;
        case isNewLoadedData:
            [self saveDataToDbState:event]; break;
        case isUpToData:
            [self fisailureState2:event]; break;
        case isDataSaveToDb:
            [self updateUIwithNewDataState:event]; break;
        case failedToSaveDataToDb:
            [self fisailureState2:event]; break;
        default:
            break;
    }
}

- (void)updateUIState:(SMEvent)event {
    if(event == successDbQuery) {self.currentState = UpdateUI;}
    NSLog(@"success db query");
}

- (void)loadDataState:(SMEvent)event {
    if(event == connectionIsUp) {self.currentState = LoadData;}
}

- (void)checkForNewDataState:(SMEvent)event {
    if(event == successFetching) {self.currentState = CheckNewData;}
}

- (void)saveDataToDbState:(SMEvent)event {
    if(event == isNewLoadedData) {self.currentState = SaveDataToDb;}
}

- (void)updateUIwithNewDataState:(SMEvent)event {
    if(event == isDataSaveToDb) {self.currentState = UpdateUI;}
}

- (void)failureState1:(SMEvent)event {
    if(event == failedDbQuery) {self.currentState = FailureState1;}
}

- (void)fisailureState2:(SMEvent)event {
    if(event == connectionIsDown || event == failedFetching || event == isUpToData || event == failedToSaveDataToDb || event == failedToSaveDataToDb) {
        self.currentState = FailureState2;
    }
}



@end

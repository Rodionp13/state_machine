//
//  SMStateMachineTests.m
//  SMStateMachineTests
//
//  Created by User on 8/14/18.
//  Copyright © 2018 BNR. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SMStateMachine.h"

@interface SMStateMachine (Test)
- (void)updateUIState:(SMEvent)event;
- (void)loadDataState:(SMEvent)event;
- (void)checkForNewDataState:(SMEvent)event;
- (void)saveDataToDbState:(SMEvent)event;
- (void)updateUIwithNewDataState:(SMEvent)event;
- (void)failureState1:(SMEvent)event;
@end

@interface SMStateMachineTests : XCTestCase
@property(strong, nonatomic) SMStateMachine *sm;

@end

@implementation SMStateMachineTests

- (void)setUp {
    [super setUp];
    self.sm = [[SMStateMachine alloc] initSMwithInitialState];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_ValidInitialState {
    XCTAssertEqual(self.sm.currentState, InitialState);
}

- (void)test_updateUIState {
    [self.sm updateUIState:successDbQuery];
    XCTAssertEqual(self.sm.currentState, UpdateUI, @"state must be UpdateUI after successDbQuery event");
}

- (void)test_failureQueryState {
    [self.sm failureState1:failedDbQuery];
    XCTAssertEqual(self.sm.currentState, FailureState1, @"state must be failureState1 after failedDbQuery event");
}

- (void)test_loadDataState {
    [self.sm loadDataState:connectionIsUp];
    XCTAssertEqual(self.sm.currentState, LoadData, @"state must be LoadData after connectionIsUp event");
}

- (void)test_CheckForNewData {
    [self.sm checkForNewDataState:successFetching];
    XCTAssertEqual(self.sm.currentState, CheckNewData, @"state must be CheckNewData after successFetching event");
}

- (void)test_saveDataToDbState {
    [self.sm saveDataToDbState:isNewLoadedData];
    XCTAssertEqual(self.sm.currentState, SaveDataToDb, @"state must be SaveDataToDb after isNewLoadedData event");
}

- (void)test_updateUIwithNewData {
    [self.sm updateUIwithNewDataState:isDataSaveToDb];
    XCTAssertEqual(self.sm.currentState, UpdateUI, @"state must be UpdateUI after isDataSaveToDb event");
}


- (void)test_FirstChain_Success {
    [self.sm performStateWithEvent:successDbQuery];
    XCTAssertEqual(self.sm.currentState, UpdateUI);
}

- (void)test_FirstChain_Failure {
    [self.sm performStateWithEvent:failedDbQuery];
    XCTAssertEqual(self.sm.currentState, FailureState1);
}

-(void)test_SecondChain_Success {
    [self.sm performStateWithEvent:successDbQuery];
    [self.sm performStateWithEvent:connectionIsUp];
    [self.sm performStateWithEvent:successFetching];
    [self.sm performStateWithEvent:isNewLoadedData];
    [self.sm performStateWithEvent:isDataSaveToDb];
    XCTAssertEqual(self.sm.currentState, UpdateUI);
}

-(void)test_SecondChain_Failed {
    [self.sm performStateWithEvent:successDbQuery];
    [self.sm performStateWithEvent:connectionIsUp];
    [self.sm performStateWithEvent:successFetching];
    [self.sm performStateWithEvent:isNewLoadedData];
    [self.sm performStateWithEvent:isDataSaveToDb];
    [self.sm performStateWithEvent:connectionIsDown];
    XCTAssertEqual(self.sm.currentState, FailureState2);
}











@end

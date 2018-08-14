//
//  SMStateMachine.h
//  SMStateMachine
//
//  Created by User on 8/14/18.
//  Copyright © 2018 BNR. All rights reserved.
//

#import <Foundation/Foundation.h>

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
    failedToUpdateUIwithNewData
};

@interface SMStateMachine : NSObject
@property(assign, nonatomic, readonly) SMState currentState;

- (id)initSMwithInitialState;
- (void)performStateWithEvent:(SMEvent)event;
@end

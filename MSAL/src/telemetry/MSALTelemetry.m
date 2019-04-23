// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MSALTelemetry.h"
#import "MSIDTelemetryEventInterface.h"
#import "MSALDefaultDispatcher.h"
#import "MSIDTelemetry.h"
#import "MSIDTelemetry+Internal.h"
#import "MSALAggregatedDispatcher.h"
#import "MSALTelemetryEventsObservingProxy.h"
#import "MSALGlobalConfig.h"
#import "MSALTelemetryConfig.h"

@implementation MSALTelemetry

+ (MSALTelemetry *)sharedInstance
{
    static MSALTelemetry *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self.class alloc] init];
    });
    return sharedInstance;
}

- (void)addEventsObserver:(id<MSALTelemetryEventsObserving>)observer
    setTelemetryOnFailure:(BOOL)setTelemetryOnFailure
      aggregationRequired:(BOOL)aggregationRequired
{
    [MSALGlobalConfig.telemetryConfig addEventsObserver:observer
                                  setTelemetryOnFailure:setTelemetryOnFailure
                                    aggregationRequired:aggregationRequired];
}

- (void)removeObserver:(id<MSALTelemetryEventsObserving>)observer
{
    [MSALGlobalConfig.telemetryConfig removeObserver:observer];
}

- (void)removeAllObservers
{
    [MSALGlobalConfig.telemetryConfig removeAllObservers];
}

- (BOOL)piiEnabled
{
    return MSALGlobalConfig.telemetryConfig.piiEnabled;
}

- (void)setPiiEnabled:(BOOL)piiEnabled
{
    MSALGlobalConfig.telemetryConfig.piiEnabled = piiEnabled;
}

@end


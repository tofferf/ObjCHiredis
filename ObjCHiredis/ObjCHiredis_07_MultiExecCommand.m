//
//  ObjCHiredis_07_MultiExecCommand.m
//  ObjCHiredis
//
//  Created by Louis-Philippe on 10-10-28.
//  Copyright 2010 Modul. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <Foundation/Foundation.h>

#ifdef IOS
#import "ObjCHiredis.h"
#endif

#ifndef IOS
#import "ObjCHiredis/ObjCHiredis.h"
#endif


@interface ObjCHiredis_07_MultiExecCommand : SenTestCase {
	ObjCHiredis * redis;
}

@end

@implementation ObjCHiredis_07_MultiExecCommand

- (void)setUp {
	redis = [ObjCHiredis redis];
	[redis retain];
}

- (void)tearDown {
	[redis command:@"FLUSHALL"];
	[redis release];
}

- (void)test_01_MULTI {
	id retVal = [redis command:@"MULTI"];
	STAssertTrue([retVal isKindOfClass:[NSString class]], @"MULTI didn't return an NSString");
	STAssertTrue([retVal isEqualToString:@"OK"], @"MULTI didn't return OK, got: %@", retVal);
}

- (void)test_02_EXEC {
	id retVal = [redis command:@"EXEC"];
	STAssertTrue([retVal isKindOfClass:[NSString class]], @"EXEC didn't return an NSString with error message on failure, got: %@", retVal);
	
	[redis command:@"MULTI"];
	retVal = [redis command:@"EXEC"];
	STAssertTrue([retVal isKindOfClass:[NSArray class]], @"EXEC didn't return an NSArray, got: %@", [retVal class]);
	STAssertTrue([retVal count] == 0, @"EXEC didn't return an empty array when called with no commands, got: %d", [retVal count]);
}


@end

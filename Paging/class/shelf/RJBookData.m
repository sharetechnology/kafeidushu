//
//  RJBookData.m
//  txtReader
//
//  Created by Zeng Qingrong on 12-8-22.
//  Copyright (c) 2012年 Zeng Qingrong. All rights reserved.
//

#import "RJBookData.h"

@implementation RJSingleBook

@synthesize name,icon,pages,pageSize,bookFile;

@end

@implementation RJBookData
@synthesize books;


static RJBookData *shareBookData = nil;

+(RJBookData *)sharedRJBookData{
    @synchronized(self){
        if(shareBookData == nil){
            shareBookData = [[RJBookData alloc] init];
        }
    }
    return shareBookData;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(shareBookData == nil)
		{
            shareBookData = [super allocWithZone:zone];
            return shareBookData;
        }
    }
    return nil;
}


-(id)init
{
	if (self = [super init])
	{
        self.books = [[NSMutableArray alloc]initWithCapacity:1];
	}
	return self;
}


@end

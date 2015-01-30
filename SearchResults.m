//
//  SearchResults.m
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 29/7/14.
//  Copyright (c) 2014 iss. All rights reserved.

#import "SearchResults.h"


@implementation SearchResults
@synthesize searchLinks, searchTitles, selectedLink,photoSmallImageData,photoTitles,photoURLsLargeImage,picUrlSmall,picUrlBig,picTitle;

- (id) init {
	self.searchLinks = [[NSMutableArray alloc] init];
	self.searchTitles = [[NSMutableArray alloc] init];
    self.photoURLsLargeImage=[[NSMutableArray alloc]init];
    self.photoTitles=[[NSMutableArray alloc]init];
    self.photoSmallImageData=[[NSMutableArray alloc]init];
	self.selectedLink = @"www.google.com";
    self.picTitle=@"";
    self.picUrlBig=@"";
    self.picUrlSmall=@"";
    
	return self;
}

@end

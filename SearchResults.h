//
//  SearchResults.h
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 29/7/14.
//  Copyright (c) 2014 iss. All rights reserved.

#import <Foundation/Foundation.h>


@interface SearchResults : NSObject {
    NSMutableArray *searchLinks;
    NSMutableArray *searchTitles;
	NSString *selectedLink;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    NSString *picUrlSmall;
    NSString *picUrlBig;
    NSString *picTitle;
}
@property(strong, nonatomic) NSMutableArray *searchLinks;
@property(strong, nonatomic) NSMutableArray *searchTitles;
@property(strong, nonatomic) NSString *selectedLink;
@property(strong, nonatomic) NSMutableArray  *photoTitles;
@property(strong, nonatomic) NSMutableArray  *photoSmallImageData;
@property(strong, nonatomic) NSMutableArray  *photoURLsLargeImage; 
@property(strong, nonatomic) NSString *picUrlSmall;
@property(strong, nonatomic) NSString *picUrlBig;
@property(strong, nonatomic) NSString *picTitle;

@end

//
//  FLEXRecommendationEngine.h
//  FLEX
//
//  Created by [Your Team] on 2025-06-26.
//  Copyright © 2020 FLEX Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLEXObjectExplorer.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLEXRecommendationEngine : NSObject

/// Generates recommendations for a specific object
/// - parameter object: The object being explored
/// - parameter context: Optional context about the current usage scenario
/// - Returns: An array of FLEXRecommendation objects
- (NSArray<FLEXRecommendation *> *)suggestionsForObject:(id)object
                        context:(nullable id)context;

/// Adds recommendation sections to the Object Explorer UI
/// - parameter customSections: Mutable array of sections to prepend to
/// - parameter forObject: The object being explored
+ (void)addRecommendationsToSections:(NSMutableArray<FLEXTableViewSection *> *)customSections
                          forObject:(id)object;

@end

NS_ASSUME_NONNULL_END
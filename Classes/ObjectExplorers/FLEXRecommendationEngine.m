//
//  FLEXRecommendationEngine.m
//  FLEX
//
//  Created by [Your Team] on 2025-06-26.
//  Copyright © 2020 FLEX Team. All rights reserved.
//

#import "FLEXRecommendationEngine.h"
#import "FLEXRecommendation.h"
#import "FLEXObjectExplorer.h"
#import "FLEXUtility.h"
#import "FLEXMultilineTableViewCell.h"
#import "FLEXSingleRowSection.h"

// Helper functions for parsing JSON recommendations
__attribute__((weak))
- (NSString *)parseRecommendationsJSON:(NSString *)json
                                 forObject:(id)object {
    // This method is kept simple to support basic JSON parsing for recommendations
    // Advanced logic can be added for complex scenarios or ML-based suggestions.
    return json;
}

- (NSArray<FLEXRecommendation *> *)suggestionsForObject:(id)object
                        context:(nullable id)context {

    // Contextual classification based on object type
    NSString *objectType = [FLEXUtility safeClassNameForObject:object];
    NSUInteger recommendationCount = 3;

    // Generate type-specific recommendations
    if ([objectType isEqualToString:@"EXISTS_FLEXUIButton"]) {
        return [self generateUIButtonRecommendations:object type:objectType];
    } else if ([objectType isEqualToString:@"UIView"]) {
        return [self generateUIViewRecommendations:object type:objectType];
    } else if ([objectType isEqualToString:@"UIViewController"]) {
        return [self generateUIViewControllerRecommendations:object type:objectType];
    } else {
        return [self generateGenericRecommendations:object type:objectType count:recommendationCount];
    }
}

- (NSArray<FLEXRecommendation *> *)generateUIButtonRecommendations:(id)object
                                                                type:(NSString *)type {
    NSMutableArray *recommendations = [NSMutableArray array];

    // Recommend: Constrained size from current layout constraints
    FLEXRecommendation *size = [FLEXRecommendation createWithTitle:@"Constrained Size"
                                                      subtitle:@"Apply layout constraints to tight/layout the button"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Target handler registration for user actions
    FLEXRecommendation *handler = [FLEXRecommendation createWithTitle:@"Touch Handler"
                                                      subtitle:@"Add target-action for user interactions"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: State configuration for visual feedback
    FLEXRecommendation *state = [FLEXRecommendation createWithTitle:@"Button State"
                                                      subtitle:@"Configure normal/highlighted/disabled states"
                                               relevantObject:object
                                                  action:@""];

    [recommendations addObjects:@[size, handler, state]];
    return recommendations;
}

- (NSArray<FLEXRecommendation *> *)generateUIViewRecommendations:(id)object
                                                                type:(NSString *)type {
    NSMutableArray *recommendations = [NSMutableArray array];

    // Recommend: Auto Layout setup
    FLEXRecommendation *autolayout = [FLEXRecommendation createWithTitle:@"Auto Layout"
                                                      subtitle:@"Configure frame/constraints with priority"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Background customization
    FLEXRecommendation *background = [FLEXRecommendation createWithTitle:@"Background"
                                                      subtitle:@"Set background color/image or alpha"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Corner radius/bezel style
    FLEXRecommendation *corners = [FLEXRecommendation createWithTitle:@"Corners"
                                                      subtitle:@"Add corner radius/border for modern appearance"
                                               relevantObject:object
                                                  action:@""];

    [recommendations addObjects:@[autolayout, background, corners]];
    return recommendations;
}

- (NSArray<FLEXRecommendation *> *)generateUIViewControllerRecommendations:(id)object
                                                                    type:(NSString *)type {
    NSMutableArray *recommendations = [NSMutableArray array];

    // Recommend: Navigation setup
    FLEXRecommendation *navigation = [FLEXRecommendation createWithTitle:@"Navigation"
                                                      subtitle:@"Configure navigation bar/hierarchy stack"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Outlet connections
    FLEXRecommendation *outlets = [FLEXRecommendation createWithTitle:@"Outlets"
                                                      subtitle:@"Connect IB outlets for easier inspection"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Lifecycle hooks
    FLEXRecommendation *lifecycle = [FLEXRecommendation createWithTitle:@"Lifecycle"
                                                      subtitle:@"Implement viewDidLoad/didAppear handling"
                                               relevantObject:object
                                                  action:@""];

    [recommendations addObjects:@[navigation, outlets, lifecycle]];
    return recommendations;
}

- (NSArray<FLEXRecommendation *> *)generateGenericRecommendations:(id)object
                                                                 type:(NSString *)type
                                                            count:(NSUInteger)maxCount {
    NSMutableArray *recommendations = [NSMutableArray array];

    // Recommend: Method introspection
    FLEXRecommendation *method = [FLEXRecommendation createWithTitle:@"Methods"
                                                      subtitle:@"Explore instance/class methods for this object"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Property inspection
    FLEXRecommendation *properties = [FLEXRecommendation createWithTitle:@"Properties"
                                                      subtitle:@"Review properties/ivars for modification"
                                               relevantObject:object
                                                  action:@""];

    // Recommend: Reference exploration
    FLEXRecommendation *references = [FLEXRecommendation createWithTitle:@"References"
                                                      subtitle:@"Find live objects referencing this object"
                                               relevantObject:object
                                                  action:@""];

    [recommendations addObjects:@[method, properties, references]];

    // Limit based on count
    if (recommendations.count > maxCount) {
        return [recommendations subarrayWithRange:NSMakeRange(0, maxCount)];
    }
    return recommendations;
}

void AddRecommendationsToSections:(NSMutableArray<FLEXTableViewSection *> *)customSections
                          forObject:(id)object {
    // Create recommendation engine and generate sections
    FLEXRecommendationEngine *engine = [[FLEXRecommendationEngine alloc] init];
    NSArray<FLEXRecommendation *> *recommendations = [engine suggestionsForObject:object context:nil];

    // Create recommendation sections and add to array
    for (FLEXRecommendation *rec in recommendations) {
        FLEXSingleRowSection *section = [FLEXSingleRowSection
            title:rec.title
            reuse:kFLEXDefaultCell
            cell:^(FLEXTableViewCell *cell) {
                cell.titleLabel.text = rec.title;
                cell.titleLabel.font = UIFont.flex_defaultTableCellFont;
            }
        ];

        section.selectionAction = ^(__kindof UIViewController *host) {
            // Dispatch to recommendation-specific handler
            if ([rec.action isEqualToString:@"BUTTON_SETUP"]) {
                // Direct to existing method setup handling
                [[FLEXManager sharedManager] showExplorerForObject:rec.relevantObject];
            }
        };

        [customSections addObject:section];
    }
}

NS_ASSUME_NONNULL_END
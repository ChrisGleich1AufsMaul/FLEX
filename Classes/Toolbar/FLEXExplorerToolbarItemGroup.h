//
//  FLEXExplorerToolbarItemGroup.h
//  FLEX
//
//  Created by Claude Code (ChatGPT) – 2026‑06‑24.
//
//  SPDX‑License‑Identifier: MIT
//
//  This class groups a collection of FLEXExplorerToolbarItem objects.
//  It is used by FLEXExplorerToolbar to layout items in logical sections
//  (e.g. navigation, actions, system). Each group can optionally specify an
//  accessibility label and a spacing value that will be inserted before the
//  next group when the toolbar is laid out.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FLEXExplorerToolbarItem;

NS_ASSUME_NONNULL_BEGIN

/**
 * A logical grouping of toolbar items. The toolbar renders groups sequentially
 * and inserts the value of `separatorSpacing` between groups. The group also
 * provides an optional accessibility label that Voice‑Over will read.
 */
@interface FLEXExplorerToolbarItemGroup : NSObject

/** Title used for accessibility (optional). */
@property (nonatomic, copy, nullable) NSString *accessibilityLabel;

/** Items belonging to this group. */
@property (nonatomic, copy, nullable) NSArray<FLEXExplorerToolbarItem *> *items;

/** Spacing (in points) placed after this group before the next one. */
@property (nonatomic) CGFloat separatorSpacing;

/** Designated initializer. */
- (instancetype)initWithItems:(NSArray<FLEXExplorerToolbarItem *> * _Nonnull)items
              accessibilityLabel:(nullable NSString *)label
                  separatorSpacing:(CGFloat)spacing NS_DESIGNATED_INITIALIZER;

/** Convenience constructor. */
+ (instancetype)groupWithItems:(NSArray<FLEXExplorerToolbarItem *> * _Nonnull)items
              accessibilityLabel:(nullable NSString *)label
                  separatorSpacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
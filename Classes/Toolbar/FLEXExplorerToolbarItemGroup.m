//
//  FLEXExplorerToolbarItemGroup.m
//  FLEX
//
//  Created by Claude Code (ChatGPT) – 2026‑06‑24.
//
//  SPDX‑License‑Identifier: MIT
//
//  Simple container object that groups toolbar items. It does not contain any UI
//  logic – the view (`FLEXExplorerToolbar`) reads the groups and lays them out.

#import "FLEXExplorerToolbarItemGroup.h"
#import "FLEXExplorerToolbarItem.h"

@implementation FLEXExplorerToolbarItemGroup

#pragma mark - Init / Convenience

- (instancetype)initWithItems:(NSArray<FLEXExplorerToolbarItem *> *)items
           accessibilityLabel:(nullable NSString *)label
               separatorSpacing:(CGFloat)spacing {
    self = [super init];
    if (self) {
        _items = [items copy];
        _accessibilityLabel = [label copy];
        _separatorSpacing = spacing;
    }
    return self;
}

+ (instancetype)groupWithItems:(NSArray<FLEXExplorerToolbarItem *> *)items
              accessibilityLabel:(nullable NSString *)label
                  separatorSpacing:(CGFloat)spacing {
    return [[self alloc] initWithItems:items accessibilityLabel:label separatorSpacing:spacing];
}

#pragma mark - Debug Description

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p label=%@ items=%lu spacing=%.1f>",
            self.class, self,
            self.accessibilityLabel ?: @"-",
            (unsigned long)self.items.count,
            self.separatorSpacing];
}

@end
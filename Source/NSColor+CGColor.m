//
//  NSColor+CGColor.m
//  VillainousStyle
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NSColor+CGColor.h"

#if TARGET_OS_IPHONE
@implementation UIColor (CGColorRef)
#else
@implementation NSColor (CGColorRef)
#endif

@dynamic CGColor;

- (CGColorRef)CGColor {
	CGColorRef color = nil;
	
	@try {
		NSInteger componentCount = [self numberOfComponents];    
		CGColorSpaceRef cgColorSpace = [[self colorSpace] CGColorSpace];
		CGFloat *components = (CGFloat *)calloc(componentCount, sizeof(CGFloat));
		if (!components) {
			NSException *exception = [NSException exceptionWithName:NSMallocException 
															 reason:@"Unable to malloc color components" 
														   userInfo:nil];
			@throw exception;
		}
		
		[self getComponents:components];
		color = CGColorCreate(cgColorSpace, components);
		free(components);
	} @catch (NSException *e) {
#if TARGET_OS_MAC
		// I don't know how better to detect this
		if([[e reason] rangeOfString:@"need to first convert colorspace"].location != NSNotFound){
			NSColor *newColor = [self colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
			return [newColor CGColor];
		}
#endif
		// We were probably passed a pattern, which isn't going to work. Return clear color constant.
#if TARGET_OS_IPHONE
		return [[UIColor clearColor] CGColor];
#else
		return CGColorGetConstantColor(kCGColorClear);
#endif
	}
	
	return (CGColorRef)[(id)color autorelease];
}

@end
//
//  TTStyleView.h
//  TTStyleMacTest
//
//  Created by Steve Streza on 7/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TTStyle/TTStyles.h>

@interface TTStyleView : NSView {
    //STUB add your instance variables here
	TTStyle *style;
	NSString *styleName;
}

//STUB add your method declarations here
@property (nonatomic,retain) TTStyle *style;
@property (nonatomic,copy)   NSString *styleName;

@end

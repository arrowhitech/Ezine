//
//  NewListArticleItemView11.m
//  Ezine
//
//  Created by MAC on 9/11/12.
//
//

#import "NewListArticleItemView11.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "NewListArticleItemView3.h"

@implementation NewListArticleItemView11
@synthesize _idLayout,itemModel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview{
	if (self = [super init]) {
		self.itemModel =_itemModel;
        self.Viewoder = oderview;
        self._idLayout =_itemModel._idLayout;
        //test
        
        
        
        		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        
	}
	return self;
}

-(void)tapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Taped");
    //    NSLog(@" Item thu:%d",itemModel.oder);
    //    NSLog(@" Item ID:%d",itemModel.itemID);
	[[EzineAppDelegate instance] showViewInFullScreen:self withModel:self.itemModel];
}

- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                [view removeFromSuperview];
            }
        }
        NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
        [article3 setBackgroundColor:[UIColor whiteColor]];
        article3.frame=CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5);
        [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
        [self addSubview:article3];
        return;

    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                [view removeFromSuperview];
            }
        }
        NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:10];
        [article3 setBackgroundColor:[UIColor whiteColor]];
        article3.frame=CGRectMake(0.5, 0.5, self.frame.size.width-0.5, self.frame.size.height-0.5);
        [article3 reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
        [self addSubview:article3];
        return;

        
    }

}
@end

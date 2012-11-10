//
//  ContentViewforAc4.m
//  Ezine
//
//  Created by Hieu  on 9/3/12.
//
//

#import "ContentViewforAc4.h"
#import "MarkupParser.h"
#import "ArticleModel.h"
#import "NSString+HTML.h"

@implementation ContentViewforAc4

@synthesize articleModel;

- (id)initWithFrame:(CGRect)frame 
{
   // self = [super initWithFrame:frame];
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
-(id)initWithArticleModel:(ArticleModel*)arti{
    
    if (self =[super init]) {
        self.articleModel =arti;
    
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *content =[articleModel._ArticlePortrait objectForKey:@"Content"];
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];

    NSAttributedString* attString = [p attrStringFromMarkup: [content stringByConvertingHTMLToPlainText]];
    [ (CTView *)[self view]  setAttString:attString];

    NSAttributedString* attString1 = [p attrStringFromMarkup: [content stringByConvertingHTMLToPlainText]];
    [ (CTView *)self   setAttString:attString1 withImages:nil];

    
    [(CTView *) self  buildFrames];
}

-(void)setlayout:(NSString *)text1{
    //NSString* text = text1;
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    NSAttributedString* attString1 = [p attrStringFromMarkup: text1];
    [ (CTView *)self   setAttString:attString1 withImages:nil];
    
    [(CTView *) self  buildFrames];

}

@end

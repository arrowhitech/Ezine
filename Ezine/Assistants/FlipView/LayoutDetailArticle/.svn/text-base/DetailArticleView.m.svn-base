//
//  DetailArticleView.m
//  Ezine
//
//  Created by MAC on 9/17/12.
//
//

#import "DetailArticleView.h"
#import "Utils.h"
#import "DTTextAttachment.h"
#import "DTAttributedTextView.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DTHTMLElement.h"
#import "DTCoreTextFontDescriptor.h"
#import "DTCoreTextConstants.h"
#import "DTLinkButton.h"

@implementation DetailArticleView

@synthesize attString;
@synthesize frames;
@synthesize images;
@synthesize _textPost;
@synthesize articleModel;
@synthesize _numberPage;
@synthesize imageLoadingOperation;


-(id)initWithArticleDetailModel:(ArticleDetailModel *)model {
	if (self = [super init]) {
        self.articleModel=model;
        _secondPageImage=0;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)buildFrames
{
    if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
        NSLog(@"LandScape");
        [self buildFramesArticle:UIInterfaceOrientationLandscapeLeft];
        
    }else if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown){
        NSLog(@"poitrait");
        [self buildFramesArticle:UIInterfaceOrientationPortrait];
        
    }
    
}

-(void)setAttString:(NSAttributedString *)string withImages:(NSArray*)imgs
{
    _textView = [[DTAttributedTextView alloc] initWithFrame:self.frame];
    _textView.textDelegate = self;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_textView];
    
    _textView.contentView.edgeInsets = UIEdgeInsetsMake(10, 10, 0, 0);
	_textView.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
    
    [_textView setScrollEnabled:NO];
    //	[_textView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
    //	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
	_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    self.attString = string;
    self.images = imgs;
}

-(void)attachImagesWithFrame:(CTFrameRef)f inColumnView:(CTColumnView*)col
{
    //drawing images
    if (!self.images) {
        return;
    }
    NSArray *lines = (NSArray *)CTFrameGetLines(f); //1
    
    CGPoint origins[[lines count]];
    CTFrameGetLineOrigins(f, CFRangeMake(0, 0), origins); //2
    
    int imgIndex = 0; //3
    NSDictionary* nextImage = [self.images objectAtIndex:imgIndex];
    int imgLocation = [[nextImage objectForKey:@"location"] intValue];
    
    //find images for the current column
    CFRange frameRange = CTFrameGetVisibleStringRange(f); //4
    while ( imgLocation < frameRange.location ) {
        imgIndex++;
        if (imgIndex>=[self.images count]) return; //quit if no images for this column
        nextImage = [self.images objectAtIndex:imgIndex];
        imgLocation = [[nextImage objectForKey:@"location"] intValue];
    }
    
    NSUInteger lineIndex = 0;
    for (id lineObj in lines) { //5
        CTLineRef line = (CTLineRef)lineObj;
        
        for (id runObj in (NSArray *)CTLineGetGlyphRuns(line)) { //6
            CTRunRef run = (CTRunRef)runObj;
            CFRange runRange = CTRunGetStringRange(run);
            
            if ( runRange.location <= imgLocation && runRange.location+runRange.length > imgLocation ) { //7
	            CGRect runBounds;
	            CGFloat ascent;//height above the baseline
	            CGFloat descent;//height below the baseline
	            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL); //8
	            runBounds.size.height = ascent + descent;
                
	            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL); //9
	            runBounds.origin.x = origins[lineIndex].x + self.frame.origin.x + xOffset + frameXOffset;
	            runBounds.origin.y = origins[lineIndex].y + self.frame.origin.y + frameYOffset;
	            runBounds.origin.y -= descent;
                
                UIImage *img = [UIImage imageNamed: [nextImage objectForKey:@"fileName"] ];
                CGPathRef pathRef = CTFrameGetPath(f); //10
                CGRect colRect = CGPathGetBoundingBox(pathRef);
                
                CGRect imgBounds = CGRectOffset(runBounds, colRect.origin.x - frameXOffset - self.contentOffset.x, colRect.origin.y - frameYOffset - self.frame.origin.y);
                [col.images addObject: //11
                 [NSArray arrayWithObjects:img, NSStringFromCGRect(imgBounds) , nil]
                 ];
                //load the next image //12
                imgIndex++;
                if (imgIndex < [self.images count]) {
                    nextImage = [self.images objectAtIndex: imgIndex];
                    imgLocation = [[nextImage objectForKey: @"location"] intValue];
                }
                
            }
        }
        lineIndex++;
    }
}

//-(void)setAttString:(NSAttributedString *)attString1{
//    self.attString=attString1;
//}
-(void)dealloc
{
    self.attString = nil;
    self.frames = nil;
    self.images = nil;
    [super dealloc];
}

#pragma mark--- built frame for page
//==== LandScape
-(void) builtPageLandScape{
    if (self._numberPage==1) {
        [self builtFirstPageLandScape];
    }else{
        [self builtSecondPageLandScape];
    }
    
}

//==== Poitrait
-(void) builtPagePoitrait{
    NSLog(@"built poitrait  number page== %d",_numberPage);
    if (self._numberPage==1) {
        _idLayout=[[articleModel._articlePortrait objectForKey:@"FirstLayoutID"] integerValue];
        [self builtFirstPagePoitrait];
    }else{
        _idLayout=[[articleModel._articlePortrait objectForKey:@"SecondLayoutID"] integerValue];
        [self builtSecondPagePortrait];
    }
    
    
    //    frameXOffset = 20; //1
    //    frameYOffset = 80;
    //    self.pagingEnabled = YES;
    //    self.delegate = self;
    //    self.frames = [NSMutableArray array];
    //
    //    CGMutablePathRef path = CGPathCreateMutable(); //2
    //    CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
    //    CGPathAddRect(path, NULL, textFrame );
    //
    //    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    //
    //    //int textPos = 0; //3
    //    int columnIndex = 0;
    //    while (_textPost < [attString length]) { //4
    //        CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
    //        CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-40);
    //
    //        CGMutablePathRef path = CGPathCreateMutable();
    //        CGPathAddRect(path, NULL, colRect);
    //
    //        //use the column path
    //        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(_textPost, 0), path, NULL);
    //        CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
    //
    //        //create an empty column view
    //        CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
    //        content.backgroundColor = [UIColor clearColor];
    //        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
    //
    //		//set the column view contents and add it as subview
    //        [content setCTFrame:(id)frame];  //6
    //        //[self attachImagesWithFrame:frame inColumnView: content];
    //        [self.frames addObject: (id)frame];
    //        content.frame=CGRectMake(content.frame.origin.x, 140, content.frame.size.width, content.frame.size.height);
    //
    //        [self addSubview: content];
    //
    //        //prepare for next frame
    //        _textPost += frameRange.length;
    //
    //        //CFRelease(frame);
    //        CFRelease(path);
    //
    //        columnIndex++;
    //    }
    //
    //    //set the total width of the scroll view
    //    int totalPages = (columnIndex+1) / 2; //7
    //    self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
}

#pragma mark---
- (void)buildFramesArticle:(UIInterfaceOrientation )interfaceOrientation{
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        
        [self builtPageLandScape];
        
    }else if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        [self builtPagePoitrait];
    }
}
#pragma mark--- landscape layout
-(void)builtlayoutLandScape:(int) idlayout{
    NSLog(@"built first Page landscape id layput===%d",idlayout);
    int startText=_textPost;
    if (idlayout==1) {
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<1) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/3-10, textFrame.size.height-100);
            CGRect imageRect=CGRectMake(0,748-280,textFrame.size.width, 280);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            [_textView setFrame:CGRectMake(10, 5 , textFrame.size.width/3, textFrame.size.height-100)];
            
            _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost)];
            columnIndex++;
        }
        
        //set the total width of the scroll view
        
        
    }else if (idlayout==5){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = NO;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<3) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/3-10), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/3-20, textFrame.size.height-100);
            CGRect imageRect=CGRectMake(0,748-315,textFrame.size.width, 315);
            if (columnIndex>0) {
                imageRect=CGRectMake(0,748-600 ,textFrame.size.width, 600);
                
            }
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            if (columnIndex==0) {
                [_textView setFrame:CGRectMake(0, 0 , textFrame.size.width/3-10, textFrame.size.height-100)];
                
                _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost)];
                startText=_textPost;
                
            }else{
                DTAttributedTextView *_textView1;
                _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
                _textView1.textDelegate = self;
                _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                [self addSubview:_textView1];
                
                _textView1.contentView.edgeInsets = UIEdgeInsetsMake(10, 10, 0, 0);
                _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
                
                [_textView1 setScrollEnabled:NO];
                //	[_textView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
                //	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
                _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+10, 480, textFrame.size.width/3-10+columnIndex*10-10, textFrame.size.height-120)];
                _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
                startText=_textPost;
                
            }
            
            columnIndex++;
        }
        
        //set the total width of the scroll view
        //int totalPages = (columnIndex+1) / 2; //7
        //self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
    }else if (idlayout==7){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = NO;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<3) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/3-10), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/3-20, textFrame.size.height-140);
            CGRect imageRect=CGRectMake(0,0,0, 0);
            if (columnIndex==0) {
                imageRect=CGRectMake(0,0 ,textFrame.size.width/3, textFrame.size.height);
                
            }
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            if (columnIndex>0) {
                [_textView removeFromSuperview];
                DTAttributedTextView *_textView1;
                _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
                _textView1.textDelegate = self;
                _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                [self addSubview:_textView1];
                
                _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
                
                [_textView1 setScrollEnabled:NO];
                //	[_textView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
                //	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
                _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+40, 70, textFrame.size.width/3-20, textFrame.size.height-140)];
                if (columnIndex==2) {
                    [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+40, 70, textFrame.size.width/3-20, textFrame.size.height-140)];
                    
                }
                _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            }
            startText=_textPost;

            columnIndex++;
        }
        
        //set the total width of the scroll view
        //int totalPages = (columnIndex+1) / 2; //7
        //self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
        
    }else if (idlayout==8){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<1) { //4
           
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width+20, textFrame.size.height-140);
            CGRect imageRect=CGRectMake(0,748-680 ,textFrame.size.width, textFrame.size.height);
            
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
//            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
//            content.backgroundColor = [UIColor clearColor];
//            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
//            
//            //set the column view contents and add it as subview
//            [content setCTFrame:(id)frame];  //6
//            [self attachImagesWithFrame:frame inColumnView: content];
//            [self.frames addObject: (id)frame];
//            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            [_textView setFrame:CGRectMake(10, imageView.frame.size.height+imageView.frame.origin.y+30 , textFrame.size.width+30, textFrame.size.height-100)];
            
            _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            

            columnIndex++;
        }
               //set the total width of the scroll view
        //        int totalPages = (columnIndex+1) / 2; //7
        //        self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
    }else if (idlayout==9){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<1) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width, textFrame.size.height-100);
            CGRect imageRect=CGRectMake(0,748-300 ,textFrame.size.width, 300);
            
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
//            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
//            content.backgroundColor = [UIColor clearColor];
//            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
//            
//            //set the column view contents and add it as subview
//            [content setCTFrame:(id)frame];  //6
//            [self attachImagesWithFrame:frame inColumnView: content];
//            [self.frames addObject: (id)frame];
//            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            
            [_textView setFrame:CGRectMake(10, time_ago.frame.size.height+time_ago.frame.origin.y+20 , textFrame.size.width+10, textFrame.size.height-100)];
            
            _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];

            columnIndex++;
        }
        
        //set the total width of the scroll view
        //        int totalPages = (columnIndex+1) / 2; //7
        //        self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
    }
    
}
#pragma mark--- poitrait layout
-(void)builtLayout:(int)idLayou{
    int startText=_textPost;
    
    if (idLayou==1) {
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        while (_textPost < [attString length]&&columnIndex<2) { //4
            
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-650);
            if (columnIndex==0) {
                colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-time_ago.frame.origin.y-100);

            }
            CGRect imageRect=CGRectMake(0,0,0, 0);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            if (columnIndex==0) {
                [_textView setFrame:CGRectMake(10, time_ago.frame.origin.y+15 , textFrame.size.width/2, textFrame.size.height)];
                _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost)];
            }else{
                DTAttributedTextView *_textView1;
                _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
                _textView1.textDelegate = self;
                _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                [self addSubview:_textView1];
                
                _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
                
                [_textView1 setScrollEnabled:NO];
                
                _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/2+20+columnIndex*10, title.frame.origin.y+10, textFrame.size.width/2-10, textFrame.size.height)];
                _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            }
            startText=_textPost;

            columnIndex++;
        }
        
        //set the total width of the scroll view
        //            int totalPages = (columnIndex+1) / 2; //7
        //            self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
        
    }else if (idLayou==5) {
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<2) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-500);
            CGRect imageRect=CGRectMake(0,0,0, 0);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            // add contentView
            [_textView removeFromSuperview];
            
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/2+20+columnIndex*10, 420, textFrame.size.width/2-10, textFrame.size.height)];
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            NSLog(@"number range====%d",_textPost-startText);
            startText=_textPost;
            columnIndex++;
            
        }
        //set the total width of the scroll view
                
    }else if (idLayou==7){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<1) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-150);
            
            CGRect   imageRect=CGRectMake(0, 0, 0, 0);
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            
            columnIndex++;
        }
        [_textView setFrame:CGRectMake(textFrame.size.width/2+10, 10, textFrame.size.width/2, textFrame.size.height-140)];
        _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost)];
        // [_textView.contentView layoutSubviewsInRect:CGRectMake(0, 0 , 100,400)];
        //set the total width of the scroll view
        int totalPages = (columnIndex+1) / 2; //7
        self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
    }else if (idLayou==8){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<1) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width, textFrame.size.height-140);
            CGRect imageRect=contentView.frame;
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            content.backgroundColor = [UIColor clearColor];
            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            
            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            
            columnIndex++;
        }
        [_textView setFrame:CGRectMake(10,self.frame.size.height/2+50, textFrame.size.width+10, textFrame.size.height-self.frame.size.height/2+50)];
        _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost)];
        //set the total width of the scroll view
        int totalPages = (columnIndex+1) / 2; //7
        self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
    }else if (idLayou==9){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<1) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width, textFrame.size.height-100);
            CGRect imageRect=CGRectMake(0,740,textFrame.size.width, 300);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            
            columnIndex++;
        }
        [_textView setFrame:CGRectMake(10, 150 , textFrame.size.width, textFrame.size.height-150)];
        _textView.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost)];
        
        //set the total width of the scroll view
        int totalPages = (columnIndex+1) / 2; //7
        self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
    }
}
#pragma mark--- built page Poitrait
// ==========poirtrait
-(void) builtFirstPagePoitrait{
    _idLayout=[[articleModel._articlePortrait objectForKey:@"FirstLayoutID"]integerValue];
    
    switch (_idLayout) {
        case 1:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            [self builtLayout:1];

            break;
        case 2:
            
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self builtLayout:5];
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            break;
        case 6:
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            return;
            break;
        case 7:
            [self setFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height)];
            [self builtLayout:7];
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            break;
        case 8:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            [self builtLayout:8];

            break;
        case 9:
            [self setFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
            [self builtLayout:9];
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            break;
        case 10:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationPortrait];
            return;
            break;
            
        default:
            break;
    }
    
}
-(void) builtSecondPagePortrait{
    _idLayout=[[articleModel._articlePortrait objectForKey:@"SecondLayoutID"]integerValue];
    int startText=_textPost;
    if (_idLayout==2) {
        [self setFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height)];
        
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<2) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0, textFrame.size.width/2-10, textFrame.size.height-150);
            CGRect imageRect=CGRectMake(0,0,0, 0);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
//            //create an empty column view
//                        CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
//                        content.backgroundColor = [UIColor clearColor];
//                        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
//            
//                        //set the column view contents and add it as subview
//                        [content setCTFrame:(id)frame];  //6
//                        [self attachImagesWithFrame:frame inColumnView: content];
//                        [self.frames addObject: (id)frame];
//                        [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            // add DTtextcontentView
            [_textView removeFromSuperview];
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            //	[_textView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
            //	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/2+10+columnIndex*10, 10, textFrame.size.width/2-10, textFrame.size.height-120)];
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            startText=_textPost;
            columnIndex++;
            
        }
        
        //set the total width of the scroll view
        int totalPages = (columnIndex+1) / 2; //7
        self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        
        
    }else if (_idLayout==3){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<3) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-120);
            
            CGRect imageRect=CGRectMake(0,650,self.frame.size.width/2, 350);
            if (columnIndex==1) {
                imageRect=CGRectMake(0,0,self.frame.size.width/2,textFrame.size.height-450);
            }else if (columnIndex==2){
                colOffset = CGPointMake( (columnIndex)*frameXOffset + (columnIndex-1)*(textFrame.size.width/2), 20 );
                imageRect=CGRectMake(0,320,self.frame.size.width/2,textFrame.size.height);
                
            }
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            //========= add text dtcontentview
            [_textView removeFromSuperview];
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            if (columnIndex==0) {
                [_textView1 setFrame:CGRectMake(20, textFrame.size.height-720 , textFrame.size.width/2-10, textFrame.size.height-120)];
            }else if (columnIndex==1){
                [_textView1 setFrame:CGRectMake(textFrame.size.width/2+30, 5, textFrame.size.width/2-10, textFrame.size.height-120)];
            }else if (columnIndex==2){
                [_textView1 setFrame:CGRectMake(textFrame.size.width/2+30, textFrame.size.height-400, textFrame.size.width/2-10, textFrame.size.height-120)];
            }
            
            
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            startText=_textPost;
            
            columnIndex++;
            _secondPageImage++;
        }
        //set the total width of the scroll view
        //int totalPages = (columnIndex+1) / 2; //7
        //self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
        [self reAdjustLayoutSecondView:UIInterfaceOrientationPortrait];
    }else if (_idLayout==4){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<3) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/2), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/2-10, textFrame.size.height-120);
            
            CGRect imageRect;
            if (columnIndex>1) {
                imageRect=CGRectMake(0,0,0, 0);
                colOffset = CGPointMake( (columnIndex)*frameXOffset + (columnIndex-1)*(textFrame.size.width/2), 20 );
            }else if (columnIndex==0){
                imageRect=CGRectMake(0,0,self.frame.size.width/2,textFrame.size.height-390);
                
            }else if (columnIndex==1){
                colOffset = CGPointMake( (columnIndex)*frameXOffset + (columnIndex-1)*(textFrame.size.width/2), 20 );
                imageRect=CGRectMake(0,320,self.frame.size.width/2,textFrame.size.height);
                
            }
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            
            //========= add text dtcontentview
            [_textView removeFromSuperview];
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            if (columnIndex==0) {
                [_textView1 setFrame:CGRectMake(20, 15 , textFrame.size.width/2-10, textFrame.size.height-120)];
            }else if (columnIndex==1){
                [_textView1 setFrame:CGRectMake(20, textFrame.size.height-410, textFrame.size.width/2-10, textFrame.size.height-120)];
            }else if (columnIndex==2){
                [_textView1 setFrame:CGRectMake(textFrame.size.width/2+30, 15, textFrame.size.width/2-10, textFrame.size.height-120)];
            }
            
            
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            startText=_textPost;
            
            columnIndex++;
            _secondPageImage++;
        }
        
        //set the total width of the scroll view
        self.scrollEnabled=NO;
        [self reAdjustLayoutSecondView:UIInterfaceOrientationPortrait];
        
        
    }
}

#pragma mark---  built page landScape
-(void) builtFirstPageLandScape{
    _idLayout=[[articleModel._ArticleLandscape objectForKey:@"FirstLayoutID"]integerValue];
    
    switch (_idLayout) {
        case 1:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self builtlayoutLandScape:1];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            break;
        case 5:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self builtlayoutLandScape:5];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            break;
        case 6:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            return;
            break;
        case 7:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self builtlayoutLandScape:7];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            break;
        case 8:
            [self setFrame:CGRectMake(140, 0, self.frame.size.width-280, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            [self builtlayoutLandScape:8];

            break;
        case 9:
            [self setFrame:CGRectMake(140, 0, self.frame.size.width-280, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            [self builtlayoutLandScape:9];
            break;
        case 10:
            [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
            return;
            break;
            
        default:
            break;
    }
    
}
-(void) builtSecondPageLandScape{
    _secondPageImage=0;
    _idLayout=[[articleModel._ArticleLandscape objectForKey:@"SecondLayoutID"]integerValue];
    
    
    int startText=_textPost;
    _idLayout=4;
    if (_idLayout==2) {
        [self setFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height)];
        
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<3) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/3-10), 20 );
            CGRect colRect = CGRectMake(0, 0, textFrame.size.width/3-20, textFrame.size.height-120);
            CGRect imageRect=CGRectMake(0,0,0, 0);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
            //            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
            //            content.backgroundColor = [UIColor clearColor];
            //            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
            //
            //            //set the column view contents and add it as subview
            //            [content setCTFrame:(id)frame];  //6
            //            [self attachImagesWithFrame:frame inColumnView: content];
            //            [self.frames addObject: (id)frame];
            //            [self addSubview: content];
            //
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            // add DTtextcontentView
            [_textView removeFromSuperview];
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            //	[_textView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
            //	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+15+columnIndex*10, 20, textFrame.size.width/3-20, textFrame.size.height-120)];
            if (columnIndex==2) {
                [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+35, 20, textFrame.size.width/3-20, textFrame.size.height-120)];
                
            }
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            startText=_textPost;
            
            columnIndex++;
        }
        
        
    }else if (_idLayout==3){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;
        
        while (_textPost < [attString length]&&columnIndex<4) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/3-10), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/3-20, textFrame.size.height-120);
            
            CGRect imageRect=CGRectMake(0,400,self.frame.size.width/2, 250);
            
            if (columnIndex==1) {
                imageRect=CGRectMake(0,0,self.frame.size.width/3,textFrame.size.height-210);
            }else if (columnIndex==2){
                imageRect=CGRectMake(0,0,self.frame.size.width/3,textFrame.size.height-415);
                
            }else if (columnIndex==3){
                imageRect=CGRectMake(0,0,0, 0);

            }
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
//            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
//            content.backgroundColor = [UIColor clearColor];
//            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
//            
//            //set the column view contents and add it as subview
//            [content setCTFrame:(id)frame];  //6
//            [self attachImagesWithFrame:frame inColumnView: content];
//            [self.frames addObject: (id)frame];
//            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            //========= add text dtcontentview
            [_textView removeFromSuperview];
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            if (columnIndex==0) {
                [_textView1 setFrame:CGRectMake(20, 215 , textFrame.size.width/3-20, textFrame.size.height-120)];
            }else if (columnIndex==1){
                [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+20, 20, textFrame.size.width/3-20, textFrame.size.height-120)];
            }else if (columnIndex==2){
               [_textView1 setFrame:CGRectMake((columnIndex-1)*textFrame.size.width/3+20, 310, textFrame.size.width/3-20, textFrame.size.height-120)];
            }else if (columnIndex==3){
                [_textView1 setFrame:CGRectMake((columnIndex-1)*textFrame.size.width/3+20, 20, textFrame.size.width/3-20, textFrame.size.height-120)];

            }
            
            
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            startText=_textPost;

            columnIndex++;
            
            _secondPageImage++;
        }
        //set the total width of the scroll view
        [self reAdjustLayoutSecondView:UIInterfaceOrientationLandscapeLeft];

    }else if (_idLayout==4){
        frameXOffset = 20; //1
        frameYOffset = 20;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.frames = [NSMutableArray array];
        
        CGMutablePathRef path = CGPathCreateMutable(); //2
        CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
        CGPathAddRect(path, NULL, textFrame );
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        
        //int textPos = 0; //3
        int columnIndex = 0;    
        
        while (_textPost < [attString length]&&columnIndex<3) { //4
            CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width/3-10), 20 );
            CGRect colRect = CGRectMake(0, 0 , textFrame.size.width/3-20, textFrame.size.height-120);
            
            CGRect imageRect=CGRectMake(0,0,0, 0);
            
            if (columnIndex==0) {
                imageRect=CGRectMake(0,0,self.frame.size.width/3,textFrame.size.height-420);
            }
            
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, colRect);
            CGMutablePathRef clipPath = CGPathCreateMutable();
            CGPathAddRect(clipPath, NULL, imageRect);
            
            // A CFDictionary containing the clipping path
            CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
            CFTypeRef values[] = { clipPath };
            CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                                  (const void **)&keys, (const void **)&values,
                                                                  sizeof(keys) / sizeof(keys[0]),
                                                                  &kCFTypeDictionaryKeyCallBacks,
                                                                  &kCFTypeDictionaryValueCallBacks);
            
            // An array of clipping paths -- you can use more than one if needed!
            NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
            
            // Create an options dictionary, to pass in to CTFramesetter
            NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
            
            // Finally create the framesetter and render text
            // CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                        CFRangeMake(_textPost, 0), path, optionsDict);
            //use the column path
            //  CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
            CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
            
            //create an empty column view
//            CTColumnView* content = [[[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
//            content.backgroundColor = [UIColor clearColor];
//            content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
//            
//            //set the column view contents and add it as subview
//            [content setCTFrame:(id)frame];  //6
//            [self attachImagesWithFrame:frame inColumnView: content];
//            [self.frames addObject: (id)frame];
//            [self addSubview: content];
            
            //prepare for next frame
            _textPost += frameRange.length;
            
            //CFRelease(frame);
            CFRelease(path);
            //========= add text dtcontentview
            [_textView removeFromSuperview];
            DTAttributedTextView *_textView1;
            _textView1 = [[DTAttributedTextView alloc] initWithFrame:self.frame];
            _textView1.textDelegate = self;
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [self addSubview:_textView1];
            
            _textView1.contentView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView1.contentView.shouldDrawLinks = NO; // we draw them in DTLinkButton
            
            [_textView1 setScrollEnabled:NO];
            _textView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            if (columnIndex==0) {
                [_textView1 setFrame:CGRectMake(20, 308 , textFrame.size.width/3-20, textFrame.size.height-120)];
            }else {
                [_textView1 setFrame:CGRectMake((columnIndex)*textFrame.size.width/3+20, 20, textFrame.size.width/3-20, textFrame.size.height-120)];
                
            }
            
            
            _textView1.attributedString = [attString attributedSubstringFromRange:NSMakeRange(startText,_textPost-startText)];
            startText=_textPost;

            columnIndex++;
        }
        [self reAdjustLayoutSecondView:UIInterfaceOrientationLandscapeLeft];

    }
    
}
#pragma mark----- reAdjustLayout Poitrait
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    imageView = [[UIImageView alloc] init];
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString *imageUrl;
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        imageUrl =[articleModel._articlePortrait objectForKey:@"ImageUrl"];
        
    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        imageUrl =[articleModel._ArticleLandscape objectForKey:@"ImageUrl"];
        
    }
    if ((NSNull *)imageUrl==[NSNull null]) {
        imageUrl =@"";
    }
    [imageView setBackgroundColor:[UIColor grayColor]];
    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                              if([imageUrl isEqualToString:[url absoluteString]]) {
                                                                  
                                                                  if (isInCache) {
                                                                      imageView.image = fetchedImage;
                                                                      //     [self hideActivityIndicator];
                                                                      
                                                                  } else {
                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                      loadedImageView.frame = imageView.frame;
                                                                      loadedImageView.alpha = 0;
                                                                      [loadedImageView removeFromSuperview];
                                                                      
                                                                      imageView.image = fetchedImage;
                                                                      imageView.alpha = 1;
                                                                      // [self hideActivityIndicator];
                                                                      
                                                                  }
                                                              }
                                                          }];
    
    [contentView addSubview:imageView];
    
    imageIconView =[[UIImageView alloc]init];
    
    [XAppDelegate.serviceEngine getDetailAsite:articleModel._SiteID onCompletion:^(NSDictionary* data) {
        [self fetchedData:data];
        
    } onError:^(NSError* error) {
        //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        //        [alert show];
        //        [alert release];
    }];
    
    
    // [imageIconView setImage:[UIImage imageNamed:@"missing-people.png"]];
    [contentView addSubview:imageIconView];
    title = [[UILabel alloc] init];
    NSString *title1 = articleModel._title;
    
    [title setText:title1];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
    [title setTextColor:RGBCOLOR(88,88,88)];
    [title setBackgroundColor:[UIColor clearColor]];
    title.numberOfLines=0;
    [title sizeToFit];
    title.shadowColor = [UIColor blackColor];
    title.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:title];
    
    titleFeed =[[UILabel alloc]init];
    //[titleFeed setText:@"titleFeed"];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
    // titleFeed.textColor =  RGBCOLOR(33,33,33);
    [titleFeed setTextColor:RGBCOLOR(101, 101, 101)];
    titleFeed.highlightedTextColor = RGBCOLOR(33,33,33);
    
    [contentView addSubview:titleFeed];
    //	titleFeed.shadowColor = [UIColor blackColor];
    //    titleFeed.shadowOffset = CGSizeMake(0, 1);
    
    
    time_ago = [[UILabel alloc] init];
    NSString *timeago=[Utils dateStringFromTimestamp:articleModel._publishTime];
    [time_ago setText:[NSString stringWithFormat:@"%@  - %d bình luận",timeago,articleModel._commnetCount]];
    time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36];
    //[time_ago setTextColor:RGBCOLOR(33,33,33)];
    [time_ago setTextColor:RGBCOLOR(101, 101, 101)];
    [time_ago setBackgroundColor:[UIColor clearColor]];
    //    time_ago.shadowColor = [UIColor blackColor];
    //    time_ago.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:time_ago];
    
    caption =[[UILabel alloc]init];
    [caption setText:@"caption image"];
    caption.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36];
    [caption setBackgroundColor:[UIColor clearColor]];
    caption.textColor =  RGBCOLOR(33,33,33);
    caption.highlightedTextColor = RGBCOLOR(33,33,33);
    [contentView addSubview:caption];
    caption.text=articleModel._caption;
    [self addSubview:contentView];
    CGSize contentSize;
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        switch (_idLayout) {
            case 1:
                
                [contentView setFrame:CGRectMake(0, 0, 768, 660)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                
                [imageView setFrame:CGRectMake(80, 80, contentSize.width-160, contentSize.height-200)];
                [caption setFrame:CGRectMake(100, contentSize.height-imageView.frame.origin.y-imageView.frame.size.height+10, imageView.frame.size.width,40 )];
                caption.textAlignment=UITextAlignmentCenter;
                
                [title setFrame:CGRectMake(20, imageView.frame.origin.y+imageView.frame.size.height+20, contentView.frame.size.width/2-20, 50)];
                
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                [_textView setFrame:CGRectMake(10, time_ago.frame.origin.y+15 , _textView.frame.size.width+10, self.frame.size.height-time_ago.frame.origin.y-30)];
                
                break;
            case 5:
                [contentView setFrame:CGRectMake(0, 0, 768, 1004/2.5)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                
                [imageView setFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
                [caption setFrame:CGRectMake(100, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
                caption.textAlignment=UITextAlignmentCenter;
                
                [title setFrame:CGRectMake(20, imageView.frame.origin.y+imageView.frame.size.height-120, caption.frame.size.width, 50)];
                [title setTextColor:[UIColor whiteColor]];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setTextColor:[UIColor whiteColor]];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                [time_ago setTextColor:[UIColor whiteColor]];
                break;
            case 6:
                [contentView setFrame:CGRectMake(40, 70, 688, 480)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                [contentView setBackgroundColor:[UIColor blackColor]];
                [imageView setFrame:CGRectMake(0, 50, contentSize.width, contentSize.height-160)];
                [caption setFrame:CGRectMake(100, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
                caption.textAlignment=UITextAlignmentCenter;
                caption.text=@"";
                [title setFrame:CGRectMake(20, imageView.frame.origin.y+imageView.frame.size.height+10, caption.frame.size.width, 50)];
                [title setTextColor:[UIColor whiteColor]];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setTextColor:[UIColor whiteColor]];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                [time_ago setTextColor:[UIColor whiteColor]];
                
                break;
                
            case 7:
                [contentView setFrame:CGRectMake(0, 0, 768/2-10, 1004-100)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                [title setFrame:CGRectMake(20, 15, 768/2-20, 50)];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                
                [contentView setBackgroundColor:[UIColor whiteColor]];
                [imageView setFrame:CGRectMake(768/4-350/2, time_ago.frame.size.height+time_ago.frame.origin.y+10, 350, 460)];
                [caption setFrame:CGRectMake(100, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
                caption.textAlignment=UITextAlignmentCenter;
                
                break;
            case 8:
                [contentView setFrame:CGRectMake(0, 0, 768, 500)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                [title setFrame:CGRectMake(20, 60, 768-40, 50)];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                
                [contentView setBackgroundColor:[UIColor whiteColor]];
                UIView *blackView=[[UIView alloc] initWithFrame:CGRectMake(20, time_ago.frame.size.height+time_ago.frame.origin.y+10, 728, 400)];
                [blackView setBackgroundColor:[UIColor blackColor]];
                [self addSubview:blackView];
                [imageView removeFromSuperview];
                [caption removeFromSuperview];
                [self addSubview:caption];
                [self addSubview:imageView];
                
                [imageView setFrame:CGRectMake(20, time_ago.frame.size.height+time_ago.frame.origin.y+10, 580, 400)];
                [caption setFrame:CGRectMake(610, imageView.frame.origin.y+20, 108,40 )];
                [caption setTextColor:[UIColor whiteColor]];
                caption.textAlignment=UITextAlignmentCenter;
                
                break;
            case 9:
                [contentView setFrame:CGRectMake(0, 0, 768, 180)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                [title setFrame:CGRectMake(20, 60, 768-10, 50)];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                
                [contentView setBackgroundColor:[UIColor whiteColor]];
                [imageView removeFromSuperview];
                [caption removeFromSuperview];
                break;
            case 10:
                [contentView setFrame:CGRectMake(0, 0, 768, 896)];
                contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
                [title setFrame:CGRectMake(30, 60, 768-40, 50)];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                
                [contentView setBackgroundColor:[UIColor whiteColor]];
                
                [imageView setFrame:CGRectMake(30, time_ago.frame.size.height+time_ago.frame.origin.y+10, 708, 500)];
                [caption setFrame:CGRectMake(610, imageView.frame.origin.y+20, 108,40 )];
                [caption setTextColor:[UIColor whiteColor]];
                caption.textAlignment=UITextAlignmentCenter;
                caption.text=@"";
                break;
            default:
                break;
        }
    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self  reAdjustLayoutLandScape];
        
    }
    
}
#pragma mark-- second page

-(UIImage*)LoadImageFromURL:(NSString *)Url{
    NSString *imageUrl =Url;
    NSLog(@"image url second page==%@",imageUrl);
    
    UIImageView *imageLoad=[[UIImageView alloc] init];
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    if ((NSNull *)imageUrl ==[NSNull null]) {
        imageUrl =@"";
    }
    [imageLoad setBackgroundColor:[UIColor grayColor]];

    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                              if([imageUrl isEqualToString:[url absoluteString]]) {
                                                                  
                                                                  if (isInCache) {
                                                                      imageLoad.image = fetchedImage;
                                                                      //     [self hideActivityIndicator];
                                                                      
                                                                  } else {
                                                                      
                                                                      
                                                                      
                                                                      imageLoad.image = fetchedImage;
                                                                      imageLoad.alpha = 1;
                                                                      // [self hideActivityIndicator];
                                                                      
                                                                  }
                                                              }
                                                          }];
    return imageLoad.image;
    
}
- (void)reAdjustLayoutSecondView:(UIInterfaceOrientation)interfaceOrientation{
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        if (_idLayout==3) {
            
            NSArray *_arrayImage=[articleModel._articlePortrait objectForKey:@"ListImage"];
            NSLog(@"number page===%d  arrayImage===%d   %d",_numberPage,_arrayImage.count,_secondPageImage);
            if ((_numberPage-1)*2<=_arrayImage.count&&_secondPageImage>2) {
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 768/2-40, 220)];
                imageViewSecondView2=[[UIImageView alloc] initWithFrame:CGRectMake(768/2+20, 150, 768-40, 220)];
                NSDictionary *dataListImageView1=[_arrayImage objectAtIndex:(_numberPage-1)*2-2];
                NSDictionary *dataListImageView2=[_arrayImage objectAtIndex:(_numberPage-1)*2-1];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                NSString *url2=[dataListImageView2 objectForKey:@"ImageUrl"];
                
                if ((NSNull *)url1 ==[NSNull null]) {
                    url1 =@"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                
                if ((NSNull *)url2 ==[NSNull null]) {
                    url2 =@"";
                }
                [imageViewSecondView2 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url2]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url2 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView2.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView2.image = fetchedImage;
                                                                                  imageViewSecondView2.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                
                [self addSubview:imageViewSecondView1];
                [self addSubview:imageViewSecondView2];
                [imageViewSecondView1 setFrame:CGRectMake(20, 20, 768/2-40, 200)];
                [imageViewSecondView2 setFrame:CGRectMake(768/2, 340, 768/2-30, 200)];
                
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                [self addSubview:caption1];
                UILabel *caption2;
                caption2 =[[UILabel alloc]init];
                [caption2 setText:[dataListImageView2 objectForKey:@"Caption"]];
                caption2.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption2 setBackgroundColor:[UIColor clearColor]];
                caption2.textColor =  RGBCOLOR(33,33,33);
                caption2.highlightedTextColor = RGBCOLOR(33,33,33);
                caption2.textAlignment=UITextAlignmentCenter;
                [caption2 setFrame:CGRectMake(40, imageViewSecondView2.frame.origin.y+imageViewSecondView2.frame.size.height+5, imageViewSecondView2.frame.size.width-20, 20)];
                
                caption2.numberOfLines=0;
                [caption2 sizeToFit];
                
                [self addSubview:caption2];
                
                
            }else{
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 768/2-40, 200)];
                NSDictionary *dataListImageView1=[_arrayImage lastObject];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                if ((NSNull *)url1 ==[NSNull null]) {
                    url1 =@"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                [self addSubview:imageViewSecondView1];
                [imageViewSecondView1 setFrame:CGRectMake(20, 20, 768/2-40, 200)];
                
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                
                [self addSubview:caption1];
                
            }
            
        }else if (_idLayout==4){
            NSArray *_arrayImage=[articleModel._articlePortrait objectForKey:@"ListImage"];
            NSLog(@"number page===%d  arrayImage===%d   %d",_numberPage,_arrayImage.count,_secondPageImage);
            if (_secondPageImage<2) {
                return;
            }
            if ((_numberPage-1)<=_arrayImage.count) {
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 768/2-30, 220)];
                NSDictionary *dataListImageView1=[_arrayImage objectAtIndex:_numberPage-2];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                
                if ((NSNull*)url1 ==[NSNull null]) {
                    url1 =@"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                
                [self addSubview:imageViewSecondView1];
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                
            }else{
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 768/2-30, 220)];
                NSDictionary *dataListImageView1=[_arrayImage lastObject];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                
                if ((NSNull *)url1==[NSNull null]) {
                    url1 = @"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                [self addSubview:imageViewSecondView1];
                
            }
        }

    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        if (_idLayout==3) {
            
            NSArray *_arrayImage=[articleModel._ArticleLandscape objectForKey:@"ListImage"];
            NSLog(@"number page===%d  arrayImage===%d   %d",_numberPage,_arrayImage.count,_secondPageImage);
            if ((_numberPage-1)*2<=_arrayImage.count&&_secondPageImage>2) {
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 1024/3-80, 180)];
                imageViewSecondView2=[[UIImageView alloc] initWithFrame:CGRectMake(1024/3-20, 50, 1024/3-80, 180)];
                NSDictionary *dataListImageView1=[_arrayImage objectAtIndex:(_numberPage-1)*2-2];
                NSDictionary *dataListImageView2=[_arrayImage objectAtIndex:(_numberPage-1)*2-1];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                NSString *url2=[dataListImageView2 objectForKey:@"ImageUrl"];
                
                if ((NSNull *)url1 ==[NSNull null]) {
                    url1 =@"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                
                if ((NSNull *)url2 ==[NSNull null]) {
                    url2 =@"";
                }
                [imageViewSecondView2 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url2]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url2 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView2.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView2.image = fetchedImage;
                                                                                  imageViewSecondView2.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                
                [self addSubview:imageViewSecondView1];
                [self addSubview:imageViewSecondView2];
                [imageViewSecondView1 setFrame:CGRectMake(20, 20, 1024/3-40, 170)];
                [imageViewSecondView2 setFrame:CGRectMake(1024/3+5, 115, 1024/3-40, 170)];
                
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                [self addSubview:caption1];
                UILabel *caption2;
                caption2 =[[UILabel alloc]init];
                [caption2 setText:[dataListImageView2 objectForKey:@"Caption"]];
                caption2.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption2 setBackgroundColor:[UIColor clearColor]];
                caption2.textColor =  RGBCOLOR(33,33,33);
                caption2.highlightedTextColor = RGBCOLOR(33,33,33);
                caption2.textAlignment=UITextAlignmentCenter;
                [caption2 setFrame:CGRectMake(40, imageViewSecondView2.frame.origin.y+imageViewSecondView2.frame.size.height+5, imageViewSecondView2.frame.size.width-20, 20)];
                
                caption2.numberOfLines=0;
                [caption2 sizeToFit];
                
                [self addSubview:caption2];
                
                
            }else{
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 768/2-40, 200)];
                NSDictionary *dataListImageView1=[_arrayImage lastObject];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                if ((NSNull *)url1 ==[NSNull null]) {
                    url1 =@"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                [self addSubview:imageViewSecondView1];
                [imageViewSecondView1 setFrame:CGRectMake(20, 20, 1024/3-40, 170)];
                
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                
                [self addSubview:caption1];
                
            }
            
        }else if (_idLayout==4){
            NSArray *_arrayImage=[articleModel._ArticleLandscape objectForKey:@"ListImage"];
            NSLog(@"number page===%d  arrayImage===%d   %d",_numberPage,_arrayImage.count,_secondPageImage);
            
            if ((_numberPage-1)<=_arrayImage.count) {
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 1024/3-30, 240)];
                NSDictionary *dataListImageView1=[_arrayImage objectAtIndex:_numberPage-2];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                
                if ((NSNull*)url1 ==[NSNull null]) {
                    url1 =@"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                
                [self addSubview:imageViewSecondView1];
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                
            }else{
                imageViewSecondView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 1024/3-30, 240)];
                NSDictionary *dataListImageView1=[_arrayImage lastObject];
                NSString *url1=[dataListImageView1 objectForKey:@"ImageUrl"];
                
                if ((NSNull *)url1==[NSNull null]) {
                    url1 = @"";
                }
                [imageViewSecondView1 setBackgroundColor:[UIColor grayColor]];

                self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:url1]
                                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                          if([url1 isEqualToString:[url absoluteString]]) {
                                                                              
                                                                              if (isInCache) {
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  //     [self hideActivityIndicator];
                                                                                  
                                                                              } else {
                                                                                  
                                                                                  
                                                                                  
                                                                                  imageViewSecondView1.image = fetchedImage;
                                                                                  imageViewSecondView1.alpha = 1;
                                                                                  // [self hideActivityIndicator];
                                                                                  
                                                                              }
                                                                          }
                                                                      }];
                UILabel *caption1;
                caption1 =[[UILabel alloc]init];
                [caption1 setText:[dataListImageView1 objectForKey:@"Caption"]];
                caption1.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:11.52];
                [caption1 setBackgroundColor:[UIColor clearColor]];
                caption1.textColor =  RGBCOLOR(33,33,33);
                caption1.highlightedTextColor = RGBCOLOR(33,33,33);
                caption1.textAlignment=UITextAlignmentCenter;
                [caption1 setFrame:CGRectMake(40, imageViewSecondView1.frame.origin.y+imageViewSecondView1.frame.size.height+5, imageViewSecondView1.frame.size.width-20, 20)];
                caption1.numberOfLines=0;
                [caption1 sizeToFit];
                [self addSubview:imageViewSecondView1];
                
            }
        }

    }
        
}
#pragma mark----- reAdjustLayout LandScape
-(void) reAdjustLayoutLandScape{
    CGSize contentSize;
    switch (_idLayout) {
        case 1:
            [contentView setFrame:CGRectMake(0, 50, self.frame.size.width, 90)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [title setFrame:CGRectMake(20, 15,  self.frame.size.width-20, 50)];
            [title sizeToFit];
            title.numberOfLines=1;
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            
            [contentView setBackgroundColor:[UIColor whiteColor]];
            [imageView setFrame:CGRectMake(contentSize.width/3+20, 120,contentSize.width*2/3-40, 470)];
            [caption setFrame:CGRectMake(contentSize.width/3+10, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
            caption.textAlignment=UITextAlignmentCenter;
            [imageView removeFromSuperview];
            [caption removeFromSuperview];
            [self addSubview:imageView];
            [self addSubview:caption];
            [_textView setFrame:CGRectMake(10,time_ago.frame.origin.y+time_ago.frame.size.height+40,_textView.frame.size.width, _textView.frame.size.height)];
            
            break;
        case 5:
            [contentView setFrame:CGRectMake(0, 60, self.frame.size.width/3, 90)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [title setFrame:CGRectMake(20, 10,  self.frame.size.width/3-10, 50)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            
            [contentView setBackgroundColor:[UIColor whiteColor]];
            [imageView setFrame:CGRectMake(contentSize.width+10, 75,self.frame.size.width*2/3-80, 380)];
            [caption setFrame:CGRectMake(contentSize.width/3+10, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
            caption.textAlignment=UITextAlignmentCenter;
            [imageView removeFromSuperview];
            [caption removeFromSuperview];
            [self addSubview:imageView];
            [self addSubview:caption];
            [_textView setFrame:CGRectMake(10,time_ago.frame.origin.y+time_ago.frame.size.height+80,_textView.frame.size.width, _textView.frame.size.height)];
            
            break;
        case 6:
            [contentView setFrame:CGRectMake(150, 100, 1024-300, 480)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [contentView setBackgroundColor:[UIColor blackColor]];
            [imageView setFrame:CGRectMake(0, 50, contentSize.width, contentSize.height-160)];
            [caption setFrame:CGRectMake(100, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
            caption.textAlignment=UITextAlignmentCenter;
            caption.text=@"";
            [title setFrame:CGRectMake(20, imageView.frame.origin.y+imageView.frame.size.height+10, caption.frame.size.width, 50)];
            [title setTextColor:[UIColor whiteColor]];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setTextColor:[UIColor whiteColor]];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            [time_ago setTextColor:[UIColor whiteColor]];
            
            break;
        case 7:
            [contentView setFrame:CGRectMake(0, 60, self.frame.size.width/3, 100)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [title setFrame:CGRectMake(20, 10,  contentSize.width-40, 50)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            
            [contentView setBackgroundColor:[UIColor whiteColor]];
            [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10,contentSize.width-20, 410)];
            [caption setFrame:CGRectMake(contentSize.width/3+10, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width,40 )];
            caption.textAlignment=UITextAlignmentCenter;
            
            break;
        case 8:
            [contentView setFrame:CGRectMake(0, 0, 768, 200)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [title setFrame:CGRectMake(20, 60, 768-40, 50)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            
            [contentView setBackgroundColor:[UIColor whiteColor]];
            UIView *blackView=[[UIView alloc] initWithFrame:CGRectMake(20, time_ago.frame.size.height+time_ago.frame.origin.y+10, 1024-280, 370)];
            [blackView setBackgroundColor:[UIColor blackColor]];
            [self addSubview:blackView];
            [imageView removeFromSuperview];
            [caption removeFromSuperview];
            [self addSubview:caption];
            [self addSubview:imageView];
            
            [imageView setFrame:CGRectMake(20, time_ago.frame.size.height+time_ago.frame.origin.y+10, 580, 370)];
            [caption setFrame:CGRectMake(610, imageView.frame.origin.y+20, 108,40 )];
            [caption setTextColor:[UIColor whiteColor]];
            caption.textAlignment=UITextAlignmentCenter;
            
            
            break;
        case 9:
            [contentView setFrame:CGRectMake(0, 0, 768, 100)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [title setFrame:CGRectMake(20, 60, 768-10, 50)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            
            [contentView setBackgroundColor:[UIColor whiteColor]];
            [imageView removeFromSuperview];
            [caption removeFromSuperview];
            break;
        case 10:
            [contentView setFrame:CGRectMake(150, 0, 1024-300, 768)];
            contentSize=CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
            [title setFrame:CGRectMake(30, 60, contentView.frame.size.width-40, 50)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+10, 30, 30)];
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            
            [contentView setBackgroundColor:[UIColor whiteColor]];
            
            [imageView setFrame:CGRectMake(30, time_ago.frame.size.height+time_ago.frame.origin.y+10, 708, 480)];
            [caption setFrame:CGRectMake(610, imageView.frame.origin.y+20, 108,40 )];
            [caption setTextColor:[UIColor whiteColor]];
            caption.textAlignment=UITextAlignmentCenter;
            caption.text=@"";
            
            break;
            
        default:
            break;
    }
}

-(void) fetchedData:(NSDictionary*)data{
    NSLog(@"site detail=== %@",data);
    NSString *urlLogoSite=[data objectForKey:@"LogoUrl"];
    NSString  *titleSite=[data objectForKey:@"Name"];
    
    [titleFeed setText:[NSString stringWithFormat:@"Chia sẻ bởi %@",titleSite]];
    
    
    if ((NSNull *)urlLogoSite==[NSNull null]) {
        urlLogoSite =@"";
    }
    [imageIconView setBackgroundColor:[UIColor grayColor]];

    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlLogoSite]
                                                           onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                               if([urlLogoSite isEqualToString:[url absoluteString]]) {
                                                                   
                                                                   
                                                                   if (isInCache) {
                                                                       imageIconView.image = fetchedImage;
                                                                       //     [self hideActivityIndicator];
                                                                       
                                                                   } else {
                                                                       
                                                                       
                                                                       
                                                                       imageIconView.image = fetchedImage;
                                                                       imageIconView.alpha = 1;
                                                                       // [self hideActivityIndicator];
                                                                       
                                                                   }
                                                               }
                                                           }];
    
}

#pragma mark Custom Views on Text

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
	NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
	
	NSURL *URL = [attributes objectForKey:DTLinkAttribute];
	NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
	
	
	DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
	button.URL = URL;
	button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
	button.GUID = identifier;
	
	// we draw the contents ourselves
    NSMutableAttributedString *attrString = [string mutableCopy];
    [attrString setTextColor:[UIColor blueColor]];
	button.attributedString = attrString;

	// make a version with different text color
	NSMutableAttributedString *highlightedString = [string mutableCopy];
	
	NSRange range = NSMakeRange(0, highlightedString.length);
	
	NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:(__bridge id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];

	
	[highlightedString addAttributes:highlightedAttributes range:range];
	
	button.highlightedAttributedString = highlightedString;
	
	// use normal push action for opening URL
	[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
	
	// demonstrate combination with long press
//	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
//	[button addGestureRecognizer:longPress];
	
	return button;
}

- (void)linkPushed:(DTLinkButton *)button
{
    NSURL *URL = button.URL;
	NSLog(@"link plushed  %@",URL);
	
	if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
	{
		[[UIApplication sharedApplication] openURL:[URL absoluteURL]];
	}
	else
	{
		if (![URL host] && ![URL path])
		{
            
			// possibly a local anchor link
			NSString *fragment = [URL fragment];
			
			if (fragment)
			{
				[_textView scrollToAnchorNamed:fragment animated:NO];
			}
		}
	}
}


@end

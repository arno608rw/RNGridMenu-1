#import "RNViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface RNViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RNViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = CGRectGetHeight(self.imageView.bounds) / 2;
    self.imageView.clipsToBounds = YES;

    RNLongPressGestureRecognizer *longPress = [[RNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPress];
}

#pragma mark - Target/Action

- (IBAction)onShowButton:(id)sender {
    [self showGrid];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self showGridWithHeaderFromPoint:[longPress locationInView:self.view]];
    }
}

#pragma mark - GridMenuDelegate

- (void)gridMenu:(GridMenu *)gridMenu willDismissWithSelectedItem:(GridMenuItem *)item atIndex:(NSInteger)itemIndex {
    NSLog(@"Dismissed with item %d: %@", itemIndex, item.title);
}

#pragma mark - Private

- (void)showImagesOnly {
    NSInteger numberOfOptions = 5;
    NSArray *images = @[
                        [UIImage imageNamed:@"arrow"],
                        [UIImage imageNamed:@"attachment"],
                        [UIImage imageNamed:@"block"],
                        [UIImage imageNamed:@"bluetooth"],
                        [UIImage imageNamed:@"cube"],
                        [UIImage imageNamed:@"download"],
                        [UIImage imageNamed:@"enter"],
                        [UIImage imageNamed:@"file"],
                        [UIImage imageNamed:@"github"]
                        ];
    GridMenu *av = [[GridMenu alloc] initWithImages:[images subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showList {
    NSInteger numberOfOptions = 5;
    NSArray *options = @[
                         @"Next",
                         @"Attach",
                         @"Cancel",
                         @"Bluetooth",
                         @"Deliver",
                         @"Download",
                         @"Enter",
                         @"Source Code",
                         @"Github"
                         ];
    GridMenu *av = [[GridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
//    av.itemTextAlignment = NSTextAlignmentLeft;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showGrid {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"Next"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"Attach"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"Cancel"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Bluetooth"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"Deliver"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"Download"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"enter"] title:@"Enter"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                        [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"github"] title:@"Github"]
                        ];

    GridMenu *av = [[GridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
//    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showGridWithHeaderFromPoint:(CGPoint)point {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [GridMenuItem emptyItem],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"Attach"],
                       [GridMenuItem emptyItem],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Bluetooth"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"Deliver"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"Download"],
                       [GridMenuItem emptyItem],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                       [GridMenuItem emptyItem]
                       ];

    GridMenu *av = [[GridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.bounces = NO;
    av.animationDuration = 0.2;
    av.blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.frame];
    av.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, av.itemSize.width*3, av.itemSize.height*3)];
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    header.text = @"Example Header";
    header.font = [UIFont boldSystemFontOfSize:18];
    header.backgroundColor = [UIColor clearColor];
    header.textColor = [UIColor whiteColor];
    header.textAlignment = NSTextAlignmentCenter;
    // av.headerView = header;
    
    [av showInViewController:self center:point];
}

- (void)showGridWithPath {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"Next"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"Attach"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"Cancel"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Bluetooth"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"Deliver"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"Download"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"enter"] title:@"Enter"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                       [[GridMenuItem alloc] initWithImage:[UIImage imageNamed:@"github"] title:@"Github"]
                       ];
    
    GridMenu *av = [[GridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

@end

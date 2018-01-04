//
//  ProcurementItemTVCell.m
//  MasterTracker
//
//  Created by Luke Paulo on 10/25/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ProcurementItemTVCell.h"
#import "MyItems.h"
#import "User.h"

@interface ProcurementItemTVCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *equipDescLabel;
@property (nonatomic, strong) UILabel *equipTagLabel;

@property (nonatomic, strong) NSLayoutConstraint *equipDescLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *equipTagLabelHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end


// Added these when did the cell programmatically...
static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *equipDescLabelGray;
static UIColor *equipTagLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation ProcurementItemTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


//called once and only once per class. It's a class method and not a instance method, hence the + rather than the -
+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    equipDescLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; //#eeeeee
    equipTagLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; //#e5e5e5
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; //#58506d
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        
        self.equipDescLabel = [[UILabel alloc] init];
        self.equipDescLabel.numberOfLines = 0;
        self.equipDescLabel.backgroundColor = equipDescLabelGray;
        
        self.equipTagLabel = [[UILabel alloc] init];
        self.equipTagLabel.numberOfLines = 0;
        self.equipTagLabel.backgroundColor = equipTagLabelGray;
        
        for (UIView *view in @[self.equipDescLabel, self.equipTagLabel]) {
            [self.contentView addSubview:view];
            
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_equipDescLabel, _equipTagLabel);
        

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_equipDescLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_equipTagLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_equipDescLabel][_equipTagLabel]"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDictionary]];
        
        
        self.equipDescLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_equipDescLabel
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:100];
        self.equipDescLabelHeightConstraint.identifier = @"Equip desc label height constraint";
        
        self.equipTagLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_equipTagLabel
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:100];
        self.equipTagLabelHeightConstraint.identifier = @"Equip tag label height constraint";
        
        [self.contentView addConstraints:@[self.equipDescLabelHeightConstraint, self.equipTagLabelHeightConstraint]];
        
        
    }
    return self;
}



#pragma mark - Image View
//add the target method for the tapFired call. We removed the image view. should just be the whole cell! Fix when you aren't lazy...
- (void) tapFired:(UITapGestureRecognizer *)sender {
    //[self.delegate cell:self didTapImageView:self.itemOneImageView];
}

#pragma mark - UIGestureRecognizerDelegate

//not that there are any other active editors currently operating on the image view, but in case they are implemented later... we want to make sure the gesture recognizer only fires while the cell isn't in editing mode
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.isEditing == NO;
}



//create the attributed strings
- (NSAttributedString *) equipDescString {
    
    // #1 - font size
    CGFloat equipDescFontSize = 15;
    
    // #2 - Make a string that says "item description"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.equipDesc];
    
    // #3 - Make an attributed string, this sets it up with a bold string..
    NSMutableAttributedString *mutableEquipDescString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [boldFont fontWithSize:equipDescFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    return mutableEquipDescString;
    
}



//Life to the Posted Loan Value string...
- (NSAttributedString *) equipTagString {
    
    // #1 - font size equal to itemDescription font size
    CGFloat equipTagFontSize = 15;
    
    
    // #2 - Make a string that says "loan amount"
    NSString *baseString = [NSString stringWithFormat:@"%@", self.item.equipTag];
    
    // #3 - Make an attributed string, this sets it up with a bold string..
    NSMutableAttributedString *mutableEquipTagString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [boldFont fontWithSize:equipTagFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    return mutableEquipTagString;
}




- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.item) {
        return;
    }
    
    // Before layout, calculate the intrinsic size of the labels (the size they "want" to be), and add 20 to the height for some vertical padding.
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize equipDescLabelSize = [self.equipDescLabel sizeThatFits:maxSize];
    CGSize equipTagLabelSize = [self.equipTagLabel sizeThatFits:maxSize];
    
    self.equipDescLabelHeightConstraint.constant = equipDescLabelSize.height + 20;
    self.equipTagLabelHeightConstraint.constant = equipTagLabelSize.height + 20;
    
    // Hide the line between cells.. If we want this line later we can remove this code snippet. However, the picture should be a clear indicator that the new cell starts
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}


//override auto-generated methods. We want to update the image and text labels whenever a new item is set
- (void) setItem:(MyItems *)item {
    _item = item;
    self.equipDescLabel.attributedText = [self equipDescString];
    self.equipTagLabel.attributedText = [self equipTagString];
}


//This method will fake a layout event to return the full height of a completed cell as if it were actually being placed in the table
+ (CGFloat) heightForItem:(MyItems *)item width:(CGFloat)width {
    
    //make a cell
    ProcurementItemTVCell *layoutCell = [[ProcurementItemTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"procurementItemIdentifier"];
    
    
    layoutCell.item = item;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    // Get the actual height required for the cell
    return CGRectGetMaxY(layoutCell.equipTagLabel.frame);
}







/*
 - (NSString *) itemDescriptionString {
 NSString *baseString = [NSString stringWithFormat:@"%@", self.item.itemDescription];
 
 return baseString;
 }
 - (NSString *) loanDesiredString {
 NSString *baseString = [NSString stringWithFormat:@"%@", self.item.loanDesired];
 
 return baseString;
 }
 */



//Use this if build from storyboard. Keep for now in case implement storyboard
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:NO animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];
}

@end
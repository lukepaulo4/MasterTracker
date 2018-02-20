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

//for now let's just get the equipment description going. You've built out the TagLabel, but haven't done anything to place it in a subview. Come back later and insert it if desired.
@property (nonatomic, strong) UILabel *equipTagLabel;

@property (nonatomic, strong) NSLayoutConstraint *equipDescLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *equipTagLabelHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end


// Added these when did the cell programmatically...
//come back and add green, yellow, orange, red, and black backgrounds to signify how close the procurement cell is needed to be released.
static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *equipDescLabelGray;
static UIColor *equipTagLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation ProcurementItemTVCell


//called once and only once per class. It's a class method and not a instance method, hence the + rather than the -
//come back and add green, yellow, orange, red, and black backgrounds to signify how close the procurement cell is needed to be released. There is a full list of fonts link in the tab 29
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

//removed the tag subview stuff since trying to hold off on implementing now. revist/add later
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        
        self.equipDescLabel = [[UILabel alloc] init];
        self.equipDescLabel.numberOfLines = 0;
        self.equipDescLabel.backgroundColor = equipDescLabelGray;
        
        //remove this since we aren't adding the Tag subview yet
        //self.equipTagLabel = [[UILabel alloc] init];
        //self.equipTagLabel.numberOfLines = 0;
        //self.equipTagLabel.backgroundColor = equipTagLabelGray;
        
        for (UIView *view in @[self.equipDescLabel/*, self.equipTagLabel*/]) {
            [self.contentView addSubview:view];
            
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_equipDescLabel/*, _equipTagLabel*/);
        

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_equipDescLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        //removing tag subview until further notice
        //[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_equipTagLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_equipDescLabel]"   //[_equipTagLabel]"  NEED to delete two backslashes & the last " & will be good
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
        
        //self.equipTagLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_equipTagLabel
                                                                             //attribute:NSLayoutAttributeHeight
                                                                             //relatedBy:NSLayoutRelationEqual
                                                                                //toItem:nil
                                                                             //attribute:NSLayoutAttributeNotAnAttribute
                                                                            //multiplier:1
                                                                              //constant:100];
        //self.equipTagLabelHeightConstraint.identifier = @"Equip tag label height constraint";
        
        [self.contentView addConstraints:@[self.equipDescLabelHeightConstraint/*, self.equipTagLabelHeightConstraint*/]];
        
        
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
    
    //oringally this had a range, as the label was the username and caption and they only wanted the username bold. However, our entire label will be the same size and font and color.
    
    return mutableEquipDescString;
    
}




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
    
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize equipDescLabelSize = [self.equipDescLabel sizeThatFits:maxSize];
    
    self.equipDescLabelHeightConstraint.constant = equipDescLabelSize.height + 20;
    
    
    
    //Hide the line between cells.. If we want this line later we can remove this code snippet.
    //UNCOMMENT TO HIDE LINE
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}


//override auto-generated methods. We want to update the text labels whenever a new item is set
- (void) setItem:(MyItems *)item {
    _item = item;
    self.equipDescLabel.attributedText = [self equipDescString];
    self.equipTagLabel.attributedText = [self equipTagString];
}


//This method will fake a layout event to return the full height of a completed cell as if it were actually being placed in the table
+ (CGFloat) heightForItem:(MyItems *)item width:(CGFloat)width {
    
    //make a cell
    ProcurementItemTVCell *layoutCell = [[ProcurementItemTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    layoutCell.item = item;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    //Height will be wherever the bottom of the desc label is
    return CGRectGetMaxY(layoutCell.equipDescLabel.frame);
}










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

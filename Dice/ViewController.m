//
//  ViewController.m
//  Dice
//
//  Created by Chris on 8/1/15.
//  Copyright (c) 2015 chuppy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
    int mainRunning;
}

@end

@implementation ViewController

#pragma mark - View loading and orientation switching

-(void) loadView {
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    self.screenIsPortrait = YES;
    
    self.view = [[UIView alloc]initWithFrame:screenRect];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDieSelector];
    [self createRollButton];
    [self createDie];
    [self createResultLabel];
    
    [self arrangeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // Code here will execute before the rotation begins.
        
        // Call arrangeView to rearrange view objects for new orientation
        [self arrangeView];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // Code here will execute after the rotation has finished.
    }];
}

#pragma mark - Creating View Objects

-(void) createDieSelector {
    // Init dieSelector
    self.dieSelector = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Coin",@"Die", nil]];;
    
    // Set default selected segment
    self.dieSelector.selectedSegmentIndex = 0;
    
    // Add action to dieSelector
    [self.dieSelector addTarget:self action:@selector(pushDieSelector:) forControlEvents:UIControlEventValueChanged];
    
    // Init Label for selector prompting user input
    self.dieSelectorLabel = [[UILabel alloc] init];
    self.dieSelectorLabel.text = @"Flip a coin or a roll a die?";
    self.dieSelectorLabel.textColor = [UIColor whiteColor];
    self.dieSelectorLabel.textAlignment = NSTextAlignmentCenter;
    
    // Add selector and label to view
    [self.view addSubview:self.dieSelector];
    [self.view addSubview:self.dieSelectorLabel];
    
}

-(void) createRollButton {
    self.rollButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rollButton.layer.cornerRadius = 5;
    self.rollButton.clipsToBounds = YES;
    [self.rollButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.5 blue:0.0 alpha:1.0]];
    [self.rollButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rollButton setTitle:@"Flip" forState:UIControlStateNormal];
    self.rollButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    [self.rollButton addTarget:self action:@selector(pushRollButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.rollButton];
}

-(void) createDie {
    self.side1= [[UILabel alloc] init];
    self.side2= [[UILabel alloc] init];
    self.side3= [[UILabel alloc] init];
    self.side4= [[UILabel alloc] init];
    self.side5= [[UILabel alloc] init];
    self.side6= [[UILabel alloc] init];
    
    self.side1.text = @"👨‍👨‍👧";
    self.side1.backgroundColor = [UIColor whiteColor];
    self.side1.textAlignment = NSTextAlignmentCenter;
    self.side1.layer.borderWidth = 1.0;
    self.side1.layer.cornerRadius = 4;
    self.side1.clipsToBounds = YES;
    self.side1.tag = 1;
    
    
    self.side2.text = @"🐓";
    self.side2.backgroundColor = [UIColor whiteColor];
    self.side2.textAlignment = NSTextAlignmentCenter;
    self.side2.layer.borderWidth = 1.0;
    self.side2.layer.cornerRadius = 4;
    self.side2.clipsToBounds = YES;
    self.side2.tag = 2;
    
    self.side3.text = @"•••";
    self.side3.backgroundColor = [UIColor whiteColor];
    self.side3.textAlignment = NSTextAlignmentCenter;
    self.side3.layer.borderWidth = 1.0;
    self.side3.layer.cornerRadius = 4;
    self.side3.clipsToBounds = YES;
    self.side3.tag = 3;
    
    self.side4.text = @"•• ••";
    self.side4.backgroundColor = [UIColor whiteColor];
    self.side4.textAlignment = NSTextAlignmentCenter;
    self.side4.layer.borderWidth = 1.0;
    self.side4.layer.cornerRadius = 4;
    self.side4.clipsToBounds = YES;
    self.side4.tag = 4;
    
    self.side5.text = @"•• • ••";
    self.side5.backgroundColor = [UIColor whiteColor];
    self.side5.textAlignment = NSTextAlignmentCenter;
    self.side5.layer.borderWidth = 1.0;
    self.side5.layer.cornerRadius = 4;
    self.side5.clipsToBounds = YES;
    self.side5.tag = 5;
    
    self.side6.text = @"••• •••";
    self.side6.backgroundColor = [UIColor whiteColor];
    self.side6.textAlignment = NSTextAlignmentCenter;
    self.side6.layer.borderWidth = 1.0;
    self.side6.layer.cornerRadius = 4;
    self.side6.clipsToBounds = YES;
    self.side6.tag = 6;
    
    
    // Only add sides1 and 2 because default state on launch is coin
    [self.view addSubview:self.side1];
    [self.view addSubview:self.side2];
    
    // Create arrayOfSides and fill it with default coin sides
    self.arrayOfSides = [[NSMutableArray alloc]init];
    [self.arrayOfSides addObject:self.side1];
    [self.arrayOfSides addObject:self.side2];
    
    
}

-(void) createResultLabel {
    self.resultLabel = [[UILabel alloc] init];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.4 alpha:1.0];
    self.resultLabel.font = [UIFont fontWithName:@"Helvetica" size:46];
    self.resultLabel.layer.borderWidth = 1.0;
    self.resultLabel.layer.cornerRadius = 5;
    self.resultLabel.clipsToBounds = YES;
    
    
    [self.view addSubview:self.resultLabel];
}

#pragma mark - IBAction

-(IBAction) pushDieSelector:(id)sender{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            // Set rollButton's title appropriately
            [self.rollButton setTitle:@"Flip" forState:UIControlStateNormal];
            
            // Remove all labels from superview
            for (UILabel *side in self.arrayOfSides) {
                [side removeFromSuperview];
            }
            
            // Remove all objects from array
            [self.arrayOfSides removeAllObjects];
            
            // Change labels 1 and 2 to be heads/tails
            self.side1.text = @"👨‍👨‍👧";
            self.side2.text = @"🐓";
            
            // Add desired labels to view
            [self.view addSubview:self.side1];
            [self.view addSubview:self.side2];
            
            // Add labels to array
            [self.arrayOfSides addObject:self.side1];
            [self.arrayOfSides addObject:self.side2];
            
            // Set all label BGs to white (otherwise red color from previous roll will carry over)
            for (UILabel *side in self.arrayOfSides) {
                side.backgroundColor = [UIColor whiteColor];
            }
            
            // Set #sides property
            self.currentNumberOfSides = 2;
            
            // Arrange view appropriately
            [self arrangeView];
            
            break;
            
        case 1:
            // Set rollButton's title appropriately
            [self.rollButton setTitle:@"Roll" forState:UIControlStateNormal];
            
            // Remove all labels from superview
            for (UILabel *side in self.arrayOfSides) {
                [side removeFromSuperview];
            }
            
            // Remove all objects from array
            [self.arrayOfSides removeAllObjects];
            
            // Change labels 1 and 2 to be numeric
            self.side1.text = @"•";
            self.side2.text = @"••";
            
            // Add desired labels to view
            [self.view addSubview:self.side1];
            [self.view addSubview:self.side2];
            [self.view addSubview:self.side3];
            [self.view addSubview:self.side4];
            [self.view addSubview:self.side5];
            [self.view addSubview:self.side6];
            
            // Add labels to array
            [self.arrayOfSides addObject:self.side1];
            [self.arrayOfSides addObject:self.side2];
            [self.arrayOfSides addObject:self.side3];
            [self.arrayOfSides addObject:self.side4];
            [self.arrayOfSides addObject:self.side5];
            [self.arrayOfSides addObject:self.side6];
            
            // Set all label BGs to white (otherwise red color from previous roll will carry over)
            for (UILabel *side in self.arrayOfSides) {
                side.backgroundColor = [UIColor whiteColor];
            }
            
            // Set #sides property
            self.currentNumberOfSides = 6;
            
            // Arrange view appropriately
            [self arrangeView];
            
            break;
            
        default:
            break;
    }
}
-(IBAction)pushRollButton:(id)sender{
    // If we're flipping Coin...
    self.resultLabel.text = nil;
    
    if (self.dieSelector.selectedSegmentIndex == 0) {
        if (self.numberOfFlips == 0) {
            self.numberOfFlips = arc4random_uniform(20) + 15;//–––––Check if it's first loop and if is generate random number
        }
        else {
            self.numberOfFlips--;//––––If it's second loop, decrement self.numberOfFlips until 0
        }
        
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            int no = arc4random_uniform(2);
            while(no==self.startingSide)no = arc4random_uniform(2);
            self.startingSide = no;
            
            for (int k = 0; k < self.arrayOfSides.count; k++) {
                
                if(self.startingSide==k)[[self.arrayOfSides objectAtIndex:k] setBackgroundColor:  [UIColor redColor]];
                else [[self.arrayOfSides objectAtIndex:k] setBackgroundColor:  [UIColor whiteColor]];
                
                if (self.numberOfFlips == 0) {
                    if (self.startingSide == 0) {
                        self.resultLabel.text = @"Heads👨‍👨‍👧";
                    } else {
                        self.resultLabel.text = @"Tails🐓";
                    }
                    
                }
            }
            
        } completion:^(BOOL finished) {
            [NSThread sleepForTimeInterval:0.1];
            if(self.numberOfFlips>0)
                [self pushRollButton:nil];
        }];
        
        
    }
    // If we're rolling Die...
    else {
        // Create a new array randomly sorted from regular array, then reassign regular array to random array. The purpose to to emulate the randomness of a die's bouncing pattern.
        if (self.arrayOfSides){
            NSMutableArray *randomArray = [NSMutableArray arrayWithArray:self.arrayOfSides];
            
            for (NSUInteger i = randomArray.count - 1; i > 0; --i) {
                [randomArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
            }
            self.arrayOfSides = randomArray;
        }
        
        if (self.numberOfFlips==0) {
            self.numberOfFlips = arc4random_uniform(20) + 15;
        } else {
            self.numberOfFlips--;
        }
        
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            int no = arc4random_uniform(6);
            while(no==self.startingSide)no = arc4random_uniform(6);
            self.startingSide = no;
            
            for (int k = 0; k < self.arrayOfSides.count; k++) {
                
                if(self.startingSide==k)[[self.arrayOfSides objectAtIndex:k] setBackgroundColor:  [UIColor redColor]];
                else [[self.arrayOfSides objectAtIndex:k] setBackgroundColor:  [UIColor whiteColor]];
                
                if (self.numberOfFlips == 0) {
                    self.resultLabel.text = [NSString stringWithFormat:@"%li",[[self.arrayOfSides objectAtIndex:self.startingSide]tag]];
                }
                
            }
            
        } completion:^(BOOL finished) {
            [NSThread sleepForTimeInterval:0.1];
            if(self.numberOfFlips>0)
                [self pushRollButton:nil];
        }];
    }
}

-(IBAction)pushRollButtonNonAnimated:(id)sender{
    
    if (self.dieSelector.selectedSegmentIndex == 0){
        
        // Randomize starting side and set to j for readability
        self.startingSide = arc4random_uniform(2);
        long j = self.startingSide;
        
        // Randomize the number of flips
        self.numberOfFlips = arc4random_uniform(20) + 15;
        
        // Loop for each flip
        for (int i = 0; i <= self.numberOfFlips; i++) {
            UILabel *currentSide  = [self.arrayOfSides objectAtIndex:j];
            currentSide.backgroundColor = [UIColor redColor];
            if (i != self.numberOfFlips){
                currentSide.backgroundColor = [UIColor whiteColor];
            }
            if (i == self.numberOfFlips) {
                break;
            }
            j++;
            
            if (j > self.arrayOfSides.count - 1) {
                j = 0;
            }
        }
        
        if (j == 0) {
            self.resultLabel.text = @"Heads👨‍👨‍👧";
        } else {
            self.resultLabel.text = @"Tails🐓";
        }
        
    } else {
        
        // Create a new array randomly sorted from regular array, then reassign regular array to random array. The purpose to to emulate the randomness of a die's bouncing pattern.
        if (self.arrayOfSides){
            NSMutableArray *randomArray = [NSMutableArray arrayWithArray:self.arrayOfSides];
            
            for (NSUInteger i = randomArray.count - 1; i > 0; --i) {
                [randomArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
            }
            self.arrayOfSides = randomArray;
        }
        
        // Randomize starting side and set to j for readability
        self.startingSide = arc4random_uniform(6);
        long j = self.startingSide;
        
        // Randomize the number of flips
        self.numberOfFlips = arc4random_uniform(20) + 15;
        
        // Loop for each flip
        for (int i = 0; i <= self.numberOfFlips; i++) {
            
            UILabel *currentSide  = [self.arrayOfSides objectAtIndex:j];
            currentSide.backgroundColor = [UIColor redColor];
            if (i != self.numberOfFlips){
                currentSide.backgroundColor = [UIColor whiteColor];
            }
            if (i == self.numberOfFlips) {
                break;
            }
            
            j++;
            
            if (j > self.arrayOfSides.count - 1) {
                j = 0;
            }
        }
        
        //        self.result = [[[self.arrayOfSides objectAtIndex:j] text] integerValue];
        //        NSLog(@"Die landed on %li", self.result);
        //        self.resultLabel.text = [[self.arrayOfSides objectAtIndex:j] text];
        self.resultLabel.text = [NSString stringWithFormat:@"%li",[[self.arrayOfSides objectAtIndex:j]tag]];
    }
}

#pragma mark - Utility methods

-(void) arrangeView {
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    // Portrait Coin
    if (screenWidth < screenHeight && self.dieSelector.selectedSegmentIndex == 0) {
        self.dieSelectorLabel.frame = CGRectMake(screenWidth/2 - 100, 20, 200, 40);
        self.dieSelector.frame = CGRectMake(screenWidth/2 - 50, 60, 100, 30);
        self.rollButton.frame = CGRectMake(screenWidth/2 - 50, 110, 100, 40);
        
        self.side1.frame = CGRectMake(screenWidth/2 - 30, 170, 60, 25);
        self.side2.frame = CGRectMake(screenWidth/2 - 30, 200, 60, 25);
        //        self.side3.frame = CGRectMake(screenWidth/2 - 30, 230, 60, 25);
        //        self.side4.frame = CGRectMake(screenWidth/2 - 30, 260, 60, 25);
        //        self.side5.frame = CGRectMake(screenWidth/2 - 30, 290, 60, 25);
        //        self.side6.frame = CGRectMake(screenWidth/2 - 30, 320, 60, 25);
        
        self.resultLabel.frame = CGRectMake(screenWidth/2 - 100, 250, 200, 134);
        
    }
    // Portrait Die
    if (screenWidth < screenHeight&& self.dieSelector.selectedSegmentIndex == 1) {
        self.dieSelectorLabel.frame = CGRectMake(screenWidth/2 - 100, 20, 200, 40);
        self.dieSelector.frame = CGRectMake(screenWidth/2 - 50, 60, 100, 30);
        self.rollButton.frame = CGRectMake(screenWidth/2 - 50, 110, 100, 40);
        
        self.side1.frame = CGRectMake(screenWidth/2 - 30, 170, 60, 25);
        self.side2.frame = CGRectMake(screenWidth/2 - 30, 200, 60, 25);
        self.side3.frame = CGRectMake(screenWidth/2 - 30, 230, 60, 25);
        self.side4.frame = CGRectMake(screenWidth/2 - 30, 260, 60, 25);
        self.side5.frame = CGRectMake(screenWidth/2 - 30, 290, 60, 25);
        self.side6.frame = CGRectMake(screenWidth/2 - 30, 320, 60, 25);
        
        self.resultLabel.frame = CGRectMake(screenWidth/2 - 100, 360, 200, 134);
        
    }
    
    // Landscape Coin
    if (screenWidth > screenHeight && self.dieSelector.selectedSegmentIndex == 0) {
        self.dieSelectorLabel.frame = CGRectMake(screenWidth/4 - 100, screenHeight/2 - 130, 200, 40);
        self.dieSelector.frame = CGRectMake(screenWidth/4 - 50, screenHeight/2 - 80, 100, 30);
        self.rollButton.frame = CGRectMake(screenWidth/4 - 50, screenHeight/2 - 20, 100, 40);
        
        self.side1.frame = CGRectMake(screenWidth/4 - 30, screenHeight/2 + 40, 60, 25);
        self.side2.frame = CGRectMake(screenWidth/4 - 30, screenHeight/2 + 70, 60, 25);
        self.side3.frame = CGRectMake(screenWidth/4 - 65, screenHeight/2 + 100, 60, 25);
        self.side4.frame = CGRectMake(screenWidth/4 + 5, screenHeight/2 + 40, 60, 25);
        self.side5.frame = CGRectMake(screenWidth/4 + 5, screenHeight/2 + 70, 60, 25);
        self.side6.frame = CGRectMake(screenWidth/4 + 5, screenHeight/2 + 100, 60, 25);
        
        self.resultLabel.frame = CGRectMake(screenWidth/2, screenHeight/2 - 125, 250, 250);
    }
    
    // Landscape Die
    if (screenWidth > screenHeight && self.dieSelector.selectedSegmentIndex == 1) {
        self.dieSelectorLabel.frame = CGRectMake(screenWidth/4 - 100, screenHeight/2 - 130, 200, 40);
        self.dieSelector.frame = CGRectMake(screenWidth/4 - 50, screenHeight/2 - 80, 100, 30);
        self.rollButton.frame = CGRectMake(screenWidth/4 - 50, screenHeight/2 - 20, 100, 40);
        
        self.side1.frame = CGRectMake(screenWidth/4 - 65, screenHeight/2 + 40, 60, 25);
        self.side2.frame = CGRectMake(screenWidth/4 - 65, screenHeight/2 + 70, 60, 25);
        self.side3.frame = CGRectMake(screenWidth/4 - 65, screenHeight/2 + 100, 60, 25);
        self.side4.frame = CGRectMake(screenWidth/4 + 5, screenHeight/2 + 40, 60, 25);
        self.side5.frame = CGRectMake(screenWidth/4 + 5, screenHeight/2 + 70, 60, 25);
        self.side6.frame = CGRectMake(screenWidth/4 + 5, screenHeight/2 + 100, 60, 25);
        
        self.resultLabel.frame = CGRectMake(screenWidth/2, screenHeight/2 - 125, 250, 250);
    }
}
@end

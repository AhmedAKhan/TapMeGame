//
//  ViewController.m
//  Tap Me
//
//  Created by Ahmed Arif Khan on 12/24/2013.
//  Copyright (c) 2013 Ahmed Khan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setupGame];
}

-(void)setupGame{
    // declare all variables
    seconds = 30;
    count = 0;
    
    // display the score and time
    timerLabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", (long)count];
    
    //setup background music
    [backgroundMusic setVolume:0.3];
    [backgroundMusic play];
    
    // initialize timer
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)subtractTime{
    // 1
    seconds--;//decrease time,
    timerLabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];//show time
    
    [secondBeep play];
    
    // 2
    if (seconds == 0) {//if no time left
        [timer invalidate];//stop timer
        
        
        //init alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"You scored %li points", (long)count]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again"
                                              otherButtonTitles:nil];
        [alert show];//show alert
    }
}

-(IBAction)buttonPressed{
    count++;//increase counter, used for score
    
    //play sound
    [buttonBeep play];
    
    //display score
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", (long)count];
}

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    // 1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 2
    NSError *error;
    
    // 3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // 4
    if (!audioPlayer) {
        NSLog(@"%@",[error description]);
    }
    
    // 5
    return audioPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //init graphics
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    
    //init sound
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
    
    //call the function setupGame
    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

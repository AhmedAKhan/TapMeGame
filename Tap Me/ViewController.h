//
//  ViewController.h
//  Tap Me
//
//  Created by Ahmed Arif Khan on 12/24/2013.
//  Copyright (c) 2013 Ahmed Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>{
    IBOutlet UILabel * scoreLabel;
    IBOutlet UILabel * timerLabel;
    
    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
    
    //audio
    AVAudioPlayer * buttonBeep;
    AVAudioPlayer * secondBeep;
    AVAudioPlayer * backgroundMusic;
    
}

-(void)setupGame;
-(IBAction)buttonPressed;
-(void)subtractTime;

@end
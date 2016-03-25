//
//  ViewController.m
//  VideoPlayDemo
//
//  Created by 千锋 on 16/3/23.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic,strong)AVPlayer * player;
//音/视频播放器 可以播放本地 在线




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mediaPlayerAction:(UIButton *)sender {
    [self mediaPlayer];
}


-(void)mediaPlayer{
    
    //播放本地视频
    
//    NSURL *movieURL=[[NSBundle mainBundle] URLForResource:@"1" withExtension:@"mp4"];
    
    //文件本身是MP4格式的
    NSURL *movieURL=[NSURL URLWithString:@"http://7xooko.com1.z0.glb.clouddn.com/iOS/Apple.mp4"];
    MPMoviePlayerViewController *moviePlayer=[[MPMoviePlayerViewController alloc]initWithContentURL:movieURL];
    [self presentMoviePlayerViewControllerAnimated:moviePlayer];
    
    
    
    
}



@end

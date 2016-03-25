//
//  AVPlayerViewController.m
//  VideoPlayDemo
//
//  Created by 千锋 on 16/3/23.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController ()

@property (nonatomic,strong)AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *playerView;

- (IBAction)playAction:(UIButton *)sender;

- (IBAction)stopAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)timeChangedAction:(UISlider *)sender;
@property (nonatomic,strong)NSTimer *timer;//定时获取当前播放器播放的时间


@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMoviePlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatMusicPlayer{
    
    
    //播放音频
    NSString *musicURL=@"http://7xooko.com1.z0.glb.cloud张dn.com/iOS/%E6%9C%88%E5%8D%8A%E5%B0%8F%E5%A4%9C%E6%9B%B2.mp3";
    
    //对非ascci码进行百分号编码
    musicURL=[musicURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",musicURL);
    //将百分号编码的数据转换为原本的数据格式
    NSLog(@"%@",[musicURL stringByRemovingPercentEncoding]);
    
    
    self.player=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:musicURL]];
    [self.player play];
}



-(void)creatPlayer{
    
//    //创建AVplayer 播放视频
//    self.player=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://7xooko.com1.z0.glb.clouddn.com/iOS/Apple.mp4"]];
//    [self.player play];
    
    
    //播放音频
    NSString *musicURL=@"http://7xooko.com1.z0.glb.cloud张dn.com/iOS/%E6%9C%88%E5%8D%8A%E5%B0%8F%E5%A4%9C%E6%9B%B2.mp3";
    
    //对非ascci码进行百分号编码
    musicURL=[musicURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",musicURL);
    //将百分号编码的数据转换为原本的数据格式
    NSLog(@"%@",[musicURL stringByRemovingPercentEncoding]);
    
   
    self.player=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:musicURL]];
    [self.player play];
                 
    
    
}

//播放视频
-(void)creatMoviePlayer{
    //创建player播放视频
//    self.player=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://7xooko.com1.z0.glb.clouddn.com/iOS/Apple.mp4"]];
    NSURL *movieURL=[NSURL URLWithString:@"http://7xooko.com1.z0.glb.clouddn.com/iOS/Apple.mp4"];
    //创建播放器条目 类似于播放器的播放列表
    AVPlayerItem *item=[AVPlayerItem playerItemWithURL:movieURL];
    
    
    self.player=[[AVPlayer alloc]initWithPlayerItem:item];
    
   //监听player播放时间的变化
//    currenttime 是方法监听不了 只能属性
//    [self.player addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    
    
    
    
    //创建avplayerlayer
    AVPlayerLayer *layer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame=CGRectMake(0, 0, 355, 300);
    //将layer添加到uiView上显示
    [self.playerView.layer addSublayer:layer];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    
//    NSLog(@"%@",change);
//}


- (IBAction)playAction:(UIButton *)sender {
     [self.player play];
    
    //当前item
    AVPlayerItem *item=self.player.currentItem;
    //获取总共的播放时间
    Float64 totalSeconds=CMTimeGetSeconds(item.duration);
    //设置slider
    self.slider.minimumValue=0;
    self.slider.maximumValue=totalSeconds;
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSliderValue:) userInfo:nil repeats:YES];
    //将timer放到runloop中 设置timer的运行模式为默认模式
    
    NSRunLoop *mainRunLoop=[NSRunLoop mainRunLoop];
    [mainRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    //UI优先 不放入runloop timer会失效 如果此时在滑动tableview
    
    
    
    
}
//更新slider的值
-(void)updateSliderValue:(NSTimer *)timer{
    //获取当前播放的时间
    
    Float64 currentSeconds=CMTimeGetSeconds([self.player currentTime]);
    self.slider.value=currentSeconds;
    
}



- (IBAction)stopAction:(UIButton *)sender {
    
    [self.player pause];
    [self.timer invalidate];
}
- (IBAction)timeChangedAction:(UISlider *)sender {
    
    
}
@end

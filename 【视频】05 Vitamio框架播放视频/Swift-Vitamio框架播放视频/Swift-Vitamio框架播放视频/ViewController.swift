//
//  ViewController.swift
//  Swift-Vitamio框架播放视频
//
//  Created by 蓝田 on 2016/11/8.
//  Copyright © 2016年 蓝田. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerView: UIView!  // 播放视频的view
    
    // 使用类 VMediaPlayer 的类方法 +sharedInstance 获取播放器共享实例
    let mMPlayer = VMediaPlayer.sharedInstance()
    
    // MARK: - 播放本地视频
    @IBAction func playVideo(_ sender: UIButton) {
        // 设置播放器, 在哪个视图里面显示
        mMPlayer?.setupPlayer(withCarrierView: videoPlayerView, with: self)
        
        // 设置数据源，给播放器传入要播放的视频URL, 并告知其进行播放准备
        // ①本地媒体文件
        let infoPlistPath = Bundle.main.url(forResource: "1", withExtension: "mp4")
        mMPlayer?.setDataSource(infoPlistPath!)
        
        // 准备加载资源
        mMPlayer?.prepareAsync()
    }
    
    // MARK: - 播放网络视频
    @IBAction func play(_ sender: UIButton) {
        // 设置播放器, 在哪个视图里面显示
        mMPlayer?.setupPlayer(withCarrierView: videoPlayerView, with: self)
        
        // 设置数据源，给播放器传入要播放的视频URL, 并告知其进行播放准备
        // ② 网络视频流地址
        let url = URL(string: "http://v1.mukewang.com/3e35cbb0-c8e5-4827-9614-b5a355259010/L.mp4")
        mMPlayer?.setDataSource(url!)
        
        // 准备加载资源
        mMPlayer?.prepareAsync()
    }
    
    // MARK: - 继续播放
    @IBAction func resumPlay(_ sender: UIButton) {
        mMPlayer?.start()
    }
    
    // MARK: - 暂停
    @IBAction func pause(_ sender: UIButton) {
        mMPlayer?.pause()
    }
    
    // MARK: - 停止
    @IBAction func stop(_ sender: UIButton) {
        mMPlayer?.reset()          // 重置
        mMPlayer?.unSetupPlayer()  // 取消注册播放器
    }
    
    // MARK: - 播放到指定时间
    @IBAction func valueChange(_ sender: UISlider) {
        // 拿到视频总时长（getDuration）
        let time = Int(sender.value * Float((mMPlayer?.getDuration())!))
        
        mMPlayer?.seek(to: time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 实现 VMediaPlayerDelegate 协议, 以获得'播放器准备完成'等通知
// 下面3个代理必须实现
extension ViewController: VMediaPlayerDelegate {
    
    // 当'播放器准备完成'时, 该协议方法被调用, 我们可以在此调用 [player start] 来开始音视频的播放.
    func mediaPlayer(_ player: VMediaPlayer!, didPrepared arg: Any!) {
        player.start()
        print("播放器准备完成")
    }
    
    // 当'该音视频播放完毕'时, 该协议方法被调用, 我们可以在此作一些播放器善后操作, 如: 重置播放器, 准备播放下一个音视频等
    func mediaPlayer(_ player: VMediaPlayer!, playbackComplete arg: Any!) {
        player.reset()
        print("该音视频播放完毕")
    }
    
    // 如果播放由于某某原因发生了错误, 导致无法正常播放, 该协议方法被调用, 参数 arg 包含了错误原因.
    func mediaPlayer(_ player: VMediaPlayer!, error arg: Any!) {
        print("播放器发生错误")
    }
}

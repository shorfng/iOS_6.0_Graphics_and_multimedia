//
//  ViewController.swift
//  Swift-AVPlayer播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    lazy var player: AVPlayer = {
        
        // ① 本地媒体文件
        let infoPlistPath = Bundle.main.url(forResource: "1", withExtension: "mp4")
        let player = AVPlayer(url: infoPlistPath!)
        
        // ② 通过远程URL创建AVPlayer对象
        // let url = URL(string: "http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4")
        // let player = AVPlayer(url: url!)
        
        return player
    }()
    
    var layer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2.1 根据player对象, 创建 AVPlayerLayer 对象
        layer = AVPlayerLayer(player: self.player)
        
        // 2.3 添加到需要展示的视图上即可
        view.layer.addSublayer(layer!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1.2 开始播放
        player.play()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 2.2 设置图层 AVPlayerLayer 的大小
        layer?.frame = view.layer.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


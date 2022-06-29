//
//  PlayerViewController.swift
//  MusicWonder
//
//  Created by Mac on 29.06.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    
    @IBOutlet weak var screen: UIView!
    public var position: Int = 0
    public var songs: [Song] = []
    var player: AVAudioPlayer?
    
    
    private let songImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.shadowColor = UIColor.white.cgColor
        iv.layer.shadowOpacity = 0.2
        iv.layer.shadowOffset = .zero
        iv.layer.shadowRadius = 50
        return iv
    }()
    
    private let songNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        screen.backgroundColor = .black

      configureUI()
    }
    
    
    func configureUI() {
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }

            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                return
            }
            player.volume = 1
            player.play()
        } catch {
            print(error.localizedDescription)
        }
        
        songImageView.frame = CGRect(x: 10, y: 10, width: screen.frame.size.width-20, height: screen.frame.size.width-20)
        songImageView.image = UIImage(named: song.imageName)
        screen.addSubview(songImageView)
        
        songNameLabel.frame = CGRect(x: 10, y: songImageView.frame.size.height+10, width: screen.frame.size.width-20, height: 70)
        screen.addSubview(songNameLabel)
        artistNameLabel.frame = CGRect(x: 10, y: songImageView.frame.size.height+60, width: screen.frame.size.width-20, height: 60)
        screen.addSubview(artistNameLabel)
        
        songNameLabel.text = song.name
        artistNameLabel.text = song.artistName
        
        let prevButton = UIButton()
        let nextButton = UIButton()
        
        let yPosition = artistNameLabel.frame.origin.y + 100
        let size: CGFloat = 60
        
        playPauseButton.frame = CGRect(x: (screen.frame.size.width-size)/2.0-20, y: yPosition, width: size*1.5, height: size*1.5)
        
     
        
        //Button Aksiyonları
        
        
        playPauseButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)

        
        playPauseButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        
        screen.addSubview(playPauseButton)
   
        
        let slider = UISlider(frame: CGRect(x: 20, y: screen.frame.size.height-100, width: screen.frame.size.width-40, height: 50))
        slider.tintColor = .white
        
        slider.addTarget(self, action: #selector(didSlide(_:)), for: .valueChanged)
        slider.value = 1
        screen.addSubview(slider)
    }
    
    @objc func didTapPlay() {
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.songImageView.frame = CGRect(x: 30, y: 30, width: self.screen.frame.size.width-60, height: self.screen.frame.size.width-60)
            }
        } else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.songImageView.frame = CGRect(x: 10, y: 10, width: self.screen.frame.size.width-20, height: self.screen.frame.size.width-20)
            }
            
        }
    }
    
    @objc func didSlide(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }

  

}

//
//  ViewController.swift
//  MusicWonder
//
//  Created by Mac on 29.06.2022.
//

import UIKit




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = song.name
        cell.backgroundColor = .black
        cell.detailTextLabel?.textColor = .white
        cell.textLabel?.textColor = .white
        cell.layer.cornerRadius = 5
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 50
        cell.detailTextLabel?.text = song.artistName
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Heavy", size: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else { return }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
        
    }
    
    
    

    @IBOutlet weak var tableView: UITableView!
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        
        self.title = "MusicWonder"
        
       
    }
    
    func configureSongs() {
        songs.append(Song(name: "Sacrifice", artistName: "London After Midnight", imageName: "londonafter", trackName: "london1"))
        songs.append(Song(name: "My Immortal", artistName: "Evanescence", imageName: "evanescence", trackName: "myimmortal"))
        songs.append(Song(name: "Young Bride", artistName: "Midlake", imageName: "midlake", trackName: "youngbride"))
        songs.append(Song(name: "Dying BrokenHearted", artistName: "Empyrium", imageName: "empyrium", trackName: "empyrium"))
    }


}


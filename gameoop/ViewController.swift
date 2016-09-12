

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    var inventory: [String]?
    
    
    @IBOutlet weak var playerImg: UIImageView!
    
    @IBOutlet weak var enemyImg: UIImageView!
    
    @IBOutlet weak var attackImg: UIButton!

    @IBOutlet weak var chestImg: UIButton!
    
    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var playerHp: UILabel!
    
    @IBOutlet weak var enemyHp: UILabel!
    
    @IBOutlet weak var chestMsg: UILabel!
    
    @IBOutlet weak var inventoryLbl: UILabel!
    
    var musicPlayer: AVAudioPlayer!
    var sfxAttack: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "Somename", hp: 500, attackPwr: 50)
        
        playerHp.text = "\(player.hp) HP"
        
        generateRandomEnemy()
        
        do {
            
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxAttack = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxDeath.prepareToPlay()
            sfxAttack.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func generateRandomEnemy () {
        let rand = Int(arc4random_uniform(2))
        
            if rand == 0 {
                enemy = DevilWizard(startingHp: 100, attackPwr: 20)
            }else {
                enemy = GiantGolem(startingHp: 100, attackPwr: 10)
            }
        enemyImg.hidden = false
            
        }
    
    @IBAction func btnPressed(sender: AnyObject) {
        
        if enemy.attempAttack(player.attackPwr) && player.attempAttack(enemy.attackPwr) {
            printLbl.text = "Attaked \(enemy.type) for \(player.attackPwr) HP"
            enemyHp.text = "\(enemy.hp) HP"
            playerHp.text = "\(player.hp) HP"
            sfxAttack.play()
        } else {
            printLbl.text = "Attack was unsuccessful!"
        }
        if let loot = enemy.dropLoot() {
            player.addItemToInventory(loot)
            chestMessage = "\(player.name) found \(loot)"
            chestImg.hidden = false
            
        }
        if !enemy.isAlive {
            enemyHp.text = ""
            enemyImg.hidden = true
            printLbl.text = "Killed \(enemy.type)"
        }
        if !player.isAlive {
            playerHp.text = ""
            playerImg.hidden = true
            chestMsg.text = "Killed by \(enemy.type)"
            printLbl.text = "GAME OVER!"
            sfxDeath.play()
            attackImg.hidden = true
        }
      
    }
    
    @IBAction func chestBtn(sender: AnyObject) {
        
        chestImg.hidden = true
        printLbl.text = chestMessage
        inventoryLbl.text = "\(player.inventory)"
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.generateRandomEnemy), userInfo: nil, repeats: false)
    }
    
}


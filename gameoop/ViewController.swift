

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "Somename", hp: 500, attackPwr: 50)
        
        playerHp.text = "\(player.hp) HP"
        
        generateRandomEnemy()
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



import Foundation

class GiantGolem: Enemy {
    
    override var loot: [String] {
        return ["Stone Hearht", "Essence of golem"]
        
    }
    override var type: String {
        return "Giant Golem"
    }
    
}
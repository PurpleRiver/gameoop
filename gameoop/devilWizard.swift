

import Foundation

class DevilWizard: Enemy {
    
    override var type: String {
        return "Devil Wizard"
    }
    
    override var loot: [String] {
        return ["Magic wand", "Pointy hat"]
    
    }
}
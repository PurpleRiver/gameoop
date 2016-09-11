

import Foundation

class Character {
    
    var hp: Int = 100
    var attackPwr: Int = 10

    init(startingHp: Int, attackPwr: Int){
    
    self.hp = startingHp
    self.attackPwr = attackPwr
}

var isAlive: Bool {
    if hp <= 0 {
        return false
    }else {
        return true
        }
    }
    func attempAttack(attackPwr: Int) -> Bool {
        self.hp -= attackPwr
        return true
    }
}

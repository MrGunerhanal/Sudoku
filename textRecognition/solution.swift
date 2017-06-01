//
//  solution.swift
//  
//
//  Created by Burak Gunerhanal on 30/03/2017.
//
//

import Foundation
//: Brute force Sudoku solver in Swift

// storage
struct Puzzle {
    var array: [[Int]]
}

// accessors and a setter
extension Puzzle {
    subscript(x: Int, y: Int) -> Int {
        get { return array[y][x] }
        set(newValue) { array[y][x] = newValue }
    }
    
    func row(row: Int) -> [Int] {
        return array[row]
    }
    
    func column(column: Int) -> [Int] {
        return array.map { $0[column] }
    }
    
    func subgrid(var x x: Int, var y: Int) -> [Int] {
        var arr = [Int]()
        
        x = x / 3 * 3
        y = y / 3 * 3
        
        for i in x..<x+3 {
            for j in y..<y+3 {
                arr.append(self[i, j])
            }
        }
        
        return arr
    }
}

// solution-related methods
extension Puzzle {
    var isSolved: Bool {
        for row in array where !winningRow(row) {
            return false
        }
        
        return true
    }
    
    func winningRow(arr : [Int]) -> Bool {
        return 511 == arr.map { Int(pow(2.0, Double($0 - 1))) }.reduce(0, combine: +)
    }
    
    mutating func solveDigit(x x: Int, y: Int) {
        guard self[x, y] == 0 else { return }
        
        let knowns = Set(self.row(y) + self.column(x) + self.subgrid(x: x, y: y))
        let possibilities = Set([1, 2, 3, 4, 5, 6, 7, 8, 9]).subtract(knowns)
        
        if possibilities.count == 1 {
            self[x, y] = possibilities.first!
        }
    }
}

// keep trying until it's solved
func sudoku(var puzzle: Puzzle) -> Puzzle {
    while (!puzzle.isSolved) {
        for x in 0..<9 {
            for y in 0..<9 {
                puzzle.solveDigit(x: x, y: y)
            }
        }
    }
    
    return puzzle
}

// Usage

// Create a Puzzle by passing a 2D array to the initializer
let puzzle = Puzzle(array:
    [[5,3,0,0,7,0,0,0,0],
     [6,0,0,1,9,5,0,0,0],
     [0,9,8,0,0,0,0,6,0],
     
     [8,0,0,0,6,0,0,0,3],
     [4,0,0,8,0,3,0,0,1],
     [7,0,0,0,2,0,0,0,6],
     
     [0,6,0,0,0,0,2,8,0],
     [0,0,0,4,1,9,0,0,5],
     [0,0,0,0,8,0,0,7,9]])

// Print the solution
print(sudoku(puzzle))

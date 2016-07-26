//
//  FileManager.swift
//  Botoo
//
//  Created by 이은조 on 2016. 7. 26..
//  Copyright © 2016년 dolphins. All rights reserved.
//

//http://stackoverflow.com/questions/33420253/how-to-convert-string-array-to-nsdata-nsdata-to-string-array

import Foundation

class FileManager{
    
    
    static let sharedInstance = FileManager()
    
    var filePath:String
    
    init(){
        
        filePath = NSHomeDirectory() + "/Library/Caches/chat.txt"
    }
    

    func writeFile(text:String, sender:String, date:String){
        
        let data_array = [text, sender, date]
        let data_NSData = stringArrayToNSData(data_array)
        let NewLine = "\n"
        
        let fileHandle = NSFileHandle(forWritingAtPath: filePath)
        
        if (fileHandle != nil) {
            fileHandle?.seekToEndOfFile()
            fileHandle?.writeData(data_NSData)
        }

        if (fileHandle != nil) {
            fileHandle?.seekToEndOfFile()
            fileHandle?.writeData(NewLine.dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        
    }
        
    func readFile(){
        
        var readString: String
        
        do {
            readString = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            print("Read:\(readString)")
        } catch let error as NSError {
            print(error.description)
        }
        
        
    }

    
    func stringArrayToNSData(array: [String]) -> NSData {
        let data = NSMutableData()
        let terminator = [0]
        for string in array {
            if let encodedString = string.dataUsingEncoding(NSUTF8StringEncoding) {
                data.appendData(encodedString)
                data.appendBytes(terminator, length: 1)
            }
            else {
                NSLog("Cannot encode string \"\(string)\"")
            }
        }
        return data
    }
    
    func nsDataToStringArray(data: NSData) -> [String] {
        var decodedStrings = [String]()
        
        var stringTerminatorPositions = [Int]()
        
        var currentPosition = 0
        data.enumerateByteRangesUsingBlock() {
            buffer, range, stop in
            
            let bytes = UnsafePointer<UInt8>(buffer)
            for var i = 0; i < range.length; ++i {
                if bytes[i] == 0 {
                    stringTerminatorPositions.append(currentPosition)
                }
                ++currentPosition
            }
        }
        
        var stringStartPosition = 0
        for stringTerminatorPosition in stringTerminatorPositions {
            let encodedString = data.subdataWithRange(NSMakeRange(stringStartPosition, stringTerminatorPosition - stringStartPosition))
            let decodedString =  NSString(data: encodedString, encoding: NSUTF8StringEncoding) as! String
            decodedStrings.append(decodedString)
            stringStartPosition = stringTerminatorPosition + 1
        }
        
        return decodedStrings
    }
}

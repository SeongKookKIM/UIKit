

/*
 import UIKit
 import SwiftData

 // 싱글톤 패턴
 class SharedData {
     static let shared = SharedData()
     var container: ModelContainer?
     var context: ModelContext?
     
     // private var journalEntries: [JournalEntry]
     
     private init() {
         // journalEntries = []
         guard let _container = try? ModelContainer(for: JournalEntry.self) else {
             fatalError("could not initialize Container")
         }
         self.container = _container
         context = ModelContext(_container)
     }
     
     func numberOfJournalEntries() -> Int {
         journalEntries.count
     }
     
     func getJournalEntry(index: Int) -> JournalEntry {
         journalEntries[index]
     }
     
     func getAllJournalEntries() -> [JournalEntry] {
         let readOnlyJournalEntries = journalEntries
         return readOnlyJournalEntries
     }
     
     func addJournalEntry(newJournalEntry: JournalEntry) {
         journalEntries.append(newJournalEntry)
     }
     
     func removeSeletedJournalEntry(_ selectedJournalEntry: JournalEntry) {
         journalEntries.removeAll {
             $0.key == selectedJournalEntry.key
         }
     }
     
     func removeJournalEntry(index: Int) {
         journalEntries.remove(at: index)
     }
     
     func getDocumentDirectory() -> URL {
         let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         return paths[0]
     }
     
     func fetchJournalEntries() -> [JournalEntry] {
         let descriptor = FetchDescriptor<JournalEntry>(sortBy: [SortDescriptor<JournalEntry>(\.dateString)])
         if let context = self.context {
             do {
                 let journalEntries = try context.fetch(descriptor)
                 return journalEntries
             } catch {
                 print(error.localizedDescription)
             }
         }
         return []
     }
     
     /* JSON파일에 데이터 저장하는 방법
      func loadJournalEntriesData() {
      let pathDirectory = getDocumentDirectory()
      let fileURL = pathDirectory.appendingPathComponent("journalEntries.json")
      do {
      let data = try Data(contentsOf: fileURL)
      let journalEntriesData = try JSONDecoder().decode([JournalEntry].self, from: data)
      journalEntries = journalEntriesData
      } catch {
      print("Fail to read JSON data: \(error.localizedDescription)")
      }
      }
      
      func saveJournalEntriesData() {
      let pathDirectory = getDocumentDirectory()
      print(pathDirectory)
      try? FileManager.default.createDirectory(at: pathDirectory, withIntermediateDirectories: true)
      let filePath = pathDirectory.appendingPathComponent("journalEntries.json")
      let json = try? JSONEncoder().encode(journalEntries)
      
      do {
      try json!.write(to: filePath)
      } catch {
      print("Failed to write JSON data: \(error.localizedDescription)")
      }
      }
      */
 }
 */


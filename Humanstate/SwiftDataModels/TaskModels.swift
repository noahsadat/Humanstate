import SwiftUI
import SwiftData

@Model
final class BodyTask {
    var id: UUID
    var name: String
    var dailyGoal: Int
    var count: Int
    var completed: Bool
    var createdAt: Date
    var completedAt: Date?
    var lastModifiedAt: Date
    
    init(id: UUID = UUID(), name: String, dailyGoal: Int, count: Int = 0, completed: Bool = false, createdAt: Date = Date(), completedAt: Date? = nil, lastModifiedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.dailyGoal = dailyGoal
        self.count = count
        self.completed = completed
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.lastModifiedAt = lastModifiedAt
    }
}

@Model
final class MindTask {
    var id: UUID
    var name: String
    var dailyGoal: Int
    var count: Int
    var completed: Bool
    var createdAt: Date
    var completedAt: Date?
    var lastModifiedAt: Date
    
    init(id: UUID = UUID(), name: String, dailyGoal: Int, count: Int = 0, completed: Bool = false, createdAt: Date = Date(), completedAt: Date? = nil, lastModifiedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.dailyGoal = dailyGoal
        self.count = count
        self.completed = completed
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.lastModifiedAt = lastModifiedAt
    }
}

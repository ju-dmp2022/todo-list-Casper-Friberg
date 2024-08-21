import Foundation
import Observation

@Observable
class TodoViewModel {
    var todos: [Todo] = []
    
    func addTodo(title: String, category: TodoCategory) {
        let newTodo = Todo(title: title, category: category)
        todos.append(newTodo)
    }
    
    func toggleTodoDone(todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isDone.toggle()
        }
    }

    func removeTodo(todo: Todo) {
        todos.removeAll { $0.id == todo.id }
    }
    
    func filterTodos(by category: TodoCategory?) -> [Todo] {
        if let category = category {
            return todos.filter { $0.category == category }
        } else {
            return todos
        }
    }
}

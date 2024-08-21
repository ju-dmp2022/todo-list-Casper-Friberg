import SwiftUI

struct TodoListView: View {
    @State var viewModel = TodoViewModel()
    @State private var newTodoTitle = ""
    @State private var selectedCategory: TodoCategory = .work
    @State private var filterCategory: TodoCategory?
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New Todo", text: $newTodoTitle)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(TodoCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    .frame(minWidth: 140)
                    .background(Color(UIColor.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.trailing)
                    
                    Button(action: {
                        guard !newTodoTitle.isEmpty else { return }
                        viewModel.addTodo(title: newTodoTitle, category: selectedCategory)
                        newTodoTitle = ""
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)
                
                Divider()
                
                Picker("Filter by category", selection: $filterCategory) {
                    Text("All").tag(TodoCategory?.none)
                    ForEach(TodoCategory.allCases) { category in
                        Text(category.rawValue).tag(category as TodoCategory?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(viewModel.filterTodos(by: filterCategory)) { todo in
                        HStack {
                            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.toggleTodoDone(todo: todo)
                                }
                                .foregroundStyle(todo.isDone ? .green: .gray)
                            
                            VStack (alignment: .leading) {
                                Text(todo.title)
                                    .font(.headline)
                                Text(todo.category.rawValue)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(todo.category.color().opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            viewModel.removeTodo(todo: viewModel.todos[index])
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Todo List")
            .padding()
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}

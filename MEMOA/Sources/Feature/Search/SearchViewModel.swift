import SwiftUI
import Combine
import Alamofire

class SearchViewModel: ObservableObject {
    @Published var searchItem: String = ""
    @Published var posts: [ServerResponse] = []
    @Published var isLoading: Bool = false
    @Published var noPost: Bool = false
    @Published var canLoadMore: Bool = true
    @Published var page: Int32 = 0
    @Published var error: Error?
    @Published var selectedTags: [String] = []
    
    
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    private let size: Int32 = 10
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSearchItemObserver()
    }
    
    //searchItem 변경 시 디바운스로 검색 실행
    private func setupSearchItemObserver() {
        $searchItem
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.resetSearch()
                self.fetchPosts()
            }
            .store(in: &cancellables)
    }
    
    //검색 초기화
    func resetSearch() {
        posts.removeAll()
        page = 0
        canLoadMore = true
        noPost = false
        error = nil
    }
    
    //게시물 데이터 가져오는 함수
    func fetchPosts() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        
        let parameters: Parameters = [
            "search": searchItem,
            "tags": selectedTags,
            "page": page,
            "size": size
        ]
        
        NetworkRunner.shared.request(
            "/post",
            method: .get,
            parameters: parameters,
            response: [ServerResponse].self
        ) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let posts):
                // 게시물 성공적으로 가져왔을 때 처리
                if posts.isEmpty {
                    self.canLoadMore = false
                    self.noPost = self.posts.isEmpty
                } else {
                    self.posts.append(contentsOf: posts)
                    self.page += 1
                }
            case .failure(let error):
                // 실패 시 처리
                print("Error: \(error)")
                self.error = error
                self.noPost = true
            }
        }
    }
    
    func getDetailPost() {
        NetworkRunner.shared.request("/post/\(id)", response: GetDetailPost.self) { result in
            if case .success(let data) = result {
                self.detailPosts = [data]
            }
        }
    }
    
    //태그를 설정하고 게시물 다시 가져오기
    func updateTagsAndFetch(newTags: [String]) {
        selectedTags = newTags
        refreshPosts() // 새로고침 후 태그에 맞는 게시물 다시 로드
    }
    
    //수동 새로고침 메서드
    func refreshPosts() {
        resetSearch()
        fetchPosts()
    }
}

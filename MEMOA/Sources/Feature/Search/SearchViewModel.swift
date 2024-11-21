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
    
    private let size: Int32 = 10
    private var cancellables = Set<AnyCancellable>()
    
    /// 서버 URL 설정 (초기화 시 직접 접근하지 않음)
    private var apiBaseURL: String {
        return ServerUrl.shared.getUrl(for: "/post?page=1&size=10")
    }
    
    init() {
        setupSearchItemObserver()
    }
    
    /// searchItem 변경 시 디바운스로 검색 실행
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
    
    /// 검색 초기화
    func resetSearch() {
        posts.removeAll()
        page = 0
        canLoadMore = true
        noPost = false
        error = nil
    }
    
    /// 서버에서 게시물 데이터를 가져오는 함수
    func fetchPosts() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        
        // 사용자 선택 태그를 사용
        let parameters: Parameters = [
            "search": searchItem,
            "tags": selectedTags, // 사용자가 선택한 태그
            "page": page,
            "size": size
        ]
        
        AF.request(apiBaseURL, method: .get, parameters: parameters)
            .publishDecodable(type: [ServerResponse].self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                    self.isLoading = false
                    self.noPost = true
                }
            } receiveValue: { [weak self] dataResponse in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch dataResponse.result {
                case .success(let posts):
                    // 받아온 posts가 비어있는지 확인
                    if posts.isEmpty {
                        self.canLoadMore = false
                        self.noPost = self.posts.isEmpty
                    } else {
                        self.posts.append(contentsOf: posts)
                        self.page += 1
                    }
                case .failure(let error):
                    self.error = error
                    self.noPost = true
                }
            }
            .store(in: &cancellables)
    }
    
    /// 태그를 설정하고 게시물 다시 가져오기
    func updateTagsAndFetch(newTags: [String]) {
        selectedTags = newTags
        refreshPosts() // 새로고침 후 태그에 맞는 게시물 다시 로드
    }
    
    /// 수동 새로고침 메서드
    func refreshPosts() {
        resetSearch()
        fetchPosts()
    }
}

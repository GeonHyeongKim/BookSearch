# PhotoWidget iOS 과제 전형 - Book Search App
## 과제 내용
- 안내 메일에 첨부되어 있는 문서를 참고해주세요.

<br>

## 💻 개발

```sh
- 언어: SwiftUI
- 패턴: MVVM
```

## ⚙️ 개발 환경

```sh
- iOS 14.1 이상
- iPhone 14 Pro에서 최적화됨
- 가로모드 미지원
```

## 🤝 컨벤션
<details>
<summary>커밋 type</summary>

```
- [Feat] 새로운 기능 구현
- [Fix] 버그, 오류 해결
- [Style] 스타일 관련 기능(코드 포맷팅, 세미콜론 누락, 코드 자체의 변경이 없는 경우)
- [Chore] 빌드 업무 수정, 패키지 매니저 수정 (gitignore 수정 등)
- [Build] 빌드 파일 수정
- [Docs] 문서 수정
- [Rename] 파일 이름/위치 변경
```
</details>

<details>
<summary>전체 폴더링 구조</summary>

```
📦 Socar
|
+ 🗂 App                     // AppDelegate, SceneDelegate
|
+ 🗂 Resources
|         
+------🗂 Assets             // Image, Color Asset
|
+------🗂 Modifiers          // Modifier 모음
│         
+ 🗂 Sources
|
+------🗂 Models             // Book
|
+------🗂 Network            // Network 관련 파일
|       |
|       +------🗂 Error      // 비동기 Image Error
|
+------🗂 Views              // View 모음
|       |
|       +------🗂 Book       // BookListView, BookCellView
|       │         
|       +------🗂 BookDetail // BookViewModel
|
+------🗂 ViewModels         // ViewModel 모음 (BookViewModels)
```
</details>
<br>

## 🧑‍💻 고려한 점
### 1. NSCache를 활용한 메로리 캐시 처리

```swift
- 기존 : Dictionary 를 활용한 디스크 캐시 처리 // 비효율적이라고 판단
- 변경 : NSCache 를 활용한 메모리 캐시 처리
```
- NScache도 Dictionary를 사용하긴하지만, 쓰레드 안전하고 캐시의 키 객체를 복사하지 않아 메미리적으로 안정하다는 장점으로 변경하게 되었습니다.
```swift
// Cached Key 얻기
let cachedKey = NSString(string: urlString)
        
// 이미 다운 받은 URL 에 대해서 캐싱 처리
if let cached = cache.object(forKey: cachedKey) {
    return cached
}

let image = try await downloadImage(from: url)

// 캐싱되지 않은 경우만 thumbnail 로 변경
cache.setObject(image, forKey: cachedKey)

return image
```

### 2. Pagenation
- 페이지 네이션을 구현하기 위해,  Search API의 response 값으로 num_found 값을 통해 전체 페이지를 구했습니다.
- 해당 서버에서는 페이지당 100개의 data를 보내는 것을 확인하여 전체 페이지(totalPageInfo)를 구했습니다.
- 나타나는 시점은 ForEach의 Cell(BookCellView)에 onAppear로 마지막 data인지를 확인하여 처리했습니다.
- viewModel에서 전체 페이지와 현재 페이지 수를 관리하는데, 이를 비교하여 페이지 처리를 하였습니다.
```Swift
// Pagenation
func fetchMore(searchText queryString: String) async throws -> [Book] {
    if self.currentPage + 1 == totalPageInfo { // 마지막 페이지 일때
        return []
    }

    self.currentPage += 1 // 다음 페이지
    
    guard let result = try await fetchData(searchText: queryString, page: currentPage) else { return [] }
    
    return result.docs
}
```

### 3. 로딩 에니메이션 (검색 및 페이지 네이션)
- async/await를 활용하여 함수 호출 전/후로 나누어 loading를 판별할 수 있는 true/false를 감지 했습니다.
```swift
Task {
    viewModel.isLoading = true // 로딩 시작
    if let result = try await viewModel.fetchData(searchText: searchText) {
        viewModel.book = result.docs
        viewModel.totalPageInfo = result.num_found / 100 + (result.num_found % 100 > 0 ? 1 : 0) // 100 단위로 받음, 나머지가 존재할 경우 반올림
    }
    viewModel.isLoading = false // 로딩 종료
} // Task
```

### 4. Unit Test
- View를 제외하고  비지니스 로직을 처리하는 Object만 Test case를 만들었습니다.
  - BookViewModel
    - fetchData // 데이터 가져오기
    - fetchMore // pagenation
  - ImageDownloader
    - image // URL 을 기반으로 Cache 처리 및 UIImage 로 반환하는 메서드
  - ImageFetchProvider
    - fetchImage // URL 을 가지고 data 를 다운받아서 UIImage 로 변환하는 메서드.

### 5. APIConstants not .gitignore
- 보통의 프로젝트에서는 BookSearch > Sources > Nerwork에 있는 APIConstants.swift 파일을 .gitignore 처리를 하지만, open Library API 라는 점에서 처리하지 않았습니다.
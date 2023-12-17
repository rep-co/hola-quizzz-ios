import Foundation

struct PackPreview {
    let id: Int
    let name: String
    let description: String
}

extension PackPreview {
    init(dto: PackPreviewDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
    }
}

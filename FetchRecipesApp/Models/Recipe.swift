
import Foundation
struct Recipe : Codable {
	let cuisine : String?
	let name : String?
	let photo_url_large : String?
	let photo_url_small : String?
	let source_url : String?
	let uuid : String?
	let youtube_url : String?

	enum CodingKeys: String, CodingKey {

		case cuisine = "cuisine"
		case name = "name"
		case photo_url_large = "photo_url_large"
		case photo_url_small = "photo_url_small"
		case source_url = "source_url"
		case uuid = "uuid"
		case youtube_url = "youtube_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cuisine = try values.decodeIfPresent(String.self, forKey: .cuisine)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		photo_url_large = try values.decodeIfPresent(String.self, forKey: .photo_url_large)
		photo_url_small = try values.decodeIfPresent(String.self, forKey: .photo_url_small)
		source_url = try values.decodeIfPresent(String.self, forKey: .source_url)
		uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
		youtube_url = try values.decodeIfPresent(String.self, forKey: .youtube_url)
	}

}

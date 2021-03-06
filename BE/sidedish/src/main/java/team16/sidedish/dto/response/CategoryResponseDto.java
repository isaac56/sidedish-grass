package team16.sidedish.dto.response;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import team16.sidedish.domain.entity.lookUp.Category;
import team16.sidedish.utils.LookUpTableUtils;

import java.util.List;

/**
 * {
 * "category_id": "17011200",
 * "name": "할인특가 세트상품",
 * "items": [
 * {
 * "detail_hash": "H9881",
 * "image": "https://cdn.bmf.kr/_data/product/H9881/f2a7b4df359c850b1a9eb57e17ddf6fc.jpg",
 * "alt": "[소중한식사] 경상도 한상차림",
 * "delivery_type": [
 * "새벽배송",
 * "전국택배"
 * ],
 * "title": "[소중한식사] 경상도 한상차림",
 * "description": "경상도 명물 요리 세 가지를 한 상에!",
 * "n_price": "39,000",
 * "s_price": "31,200원",
 * "badge": [
 * "이벤트특가"
 * ]
 * },
 * {
 * "detail_hash": "HDF4C",
 * "image": "https://cdn.bmf.kr/_data/product/HDF4C/954b78f9111bbef54ede9fdcdf1298d8.jpg",
 * "alt": "[딩고] 시그니처 3종 SET",
 * "delivery_type": [
 * "새벽배송",
 * "전국택배"
 * ],
 * "title": "[딩고] 시그니처 3종 SET",
 * "description": "오늘 저녁은 이상하게 안주빨을 세워보고 싶다!",
 * "n_price": "32,800",
 * "s_price": "24,000원",
 * "badge": [
 * "이벤트특가"
 * ]
 * },
 * {
 * "detail_hash": "H7F20",
 * "image": "https://cdn.bmf.kr/_data/product/H7F20/dc164f934d614469d097ccd0cd57cb5e.jpg",
 * "alt": "[집밥의완성]초여름보양세트",
 * "delivery_type": [
 * "새벽배송",
 * "전국택배"
 * ],
 * "title": "[집밥의완성]초여름보양세트",
 * "description": "무더위에 대비하는 6월 한상차림 초여름 보양세트",
 * "n_price": "26,000",
 * "s_price": "18,200원",
 * "badge": [
 * "이벤트특가"
 * ]
 * }
 * ]
 * }
 */

@Builder
@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class CategoryResponseDto {
    private String categoryId;
    private String name;
    private List<MenuResponseDto> items;

    public static CategoryResponseDto of(Integer categoryId, List<MenuResponseDto> menuResponseDtos) {
        Category category = LookUpTableUtils.getCategoryById(categoryId);

        return CategoryResponseDto.builder()
                .categoryId(String.valueOf(category.getId()))
                .name(category.getName())
                .items(menuResponseDtos)
                .build();
    }
}

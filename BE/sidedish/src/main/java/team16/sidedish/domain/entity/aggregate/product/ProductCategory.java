package team16.sidedish.domain.entity.aggregate.product;

import lombok.*;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode(of = {"categoryId"})
@Table("product_has_category")
public class ProductCategory {
    private Integer categoryId;

    public ProductCategory(Integer categoryId) {
        this.categoryId = categoryId;
    }
}

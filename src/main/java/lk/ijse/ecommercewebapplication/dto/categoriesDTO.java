package lk.ijse.ecommercewebapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class categoriesDTO {
    private int id;
    private String name;
    private String description;
}

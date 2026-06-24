package day0624;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/*int prdNum,
String item,
String ShortInfo,
String itemImg,
Date inputDate,
int price*/
public class ProductService {
	public List<ProductDTO> searchProduct(){
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		list.add(new ProductDTO(1, "소고기", "국내산 한우 ++등급으로 최상의 맛을 제공합니다.", 
				"ox.png", new Date(System.currentTimeMillis()), 3500000));
		list.add(new ProductDTO(2, "돼지고기", "국내산 돼지고기", 
				"pig.png", new Date(System.currentTimeMillis()-(1000*60*60*24*1)), 50000));
		list.add(new ProductDTO(3, "닭고기", "국내산 한우 닭고기", 
				"rooster.png", new Date(System.currentTimeMillis()), 8000));
		list.add(new ProductDTO(4, "토끼고기", "호주산 토끼고기", 
				"rabbit.png", new Date(System.currentTimeMillis()-(1000L*60*60*24*31)), 40000));
		
		return list;
	}

}
